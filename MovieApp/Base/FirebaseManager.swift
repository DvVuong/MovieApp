//
//  FirebaseManager.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import UIKit

class FirebaseManager {
    static let shared = FirebaseManager()
    private let _db = Firestore.firestore()
    private var _ref: DocumentReference? = nil
    private let _user = "User"
    private let _message = "Message"
    private var _arrayUser = [UserResponse]()
   
    private var dataSource = DetailDataSource()
    private var imageUrl = ""
    var queue = DispatchQueue(label: "FetchMessage", qos: .background)
    
    func resgiterAccount(with email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(authResult, error)
        }
    }
    
    func loginAccount(with email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            completion(authResult, error)
        }
    }
    
    func logout(_ completion: () -> Void) {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("error.localizedDescription")
        }
        
        completion()
    }
    
    func createAccount(_ email: String, userName: String, id: String, isActive: Bool) {
        let userData = ["email": email,
                        "userName": userName,
                        "id": id,
                        "active": isActive
        ] as [String : Any]
        _db.collection(_user).document(id).setData(userData)
        UserDefaultManager.shared.getIdUser(id)
    }
    
    func changeStateForUser(with userID: String, isActive: Bool) {
        _db.collection(_user).document(userID).updateData(["active": isActive])
    }
    
    func fecthUserData(_ completion: @escaping ([UserResponse]) -> Void) {
        self._arrayUser.removeAll()
        _db.collection(_user).addSnapshotListener { dataSnapshot, error in
            guard error == nil else { return }
            guard let querySnapshot = dataSnapshot?.documentChanges else { return }
            self._arrayUser.removeAll()
            for item in querySnapshot {
                let userData = UserResponse.init(json: item.document.data())
                self._arrayUser.append(userData)
            }
            completion(self._arrayUser)
        }
    }
    //MARK: - Create Message
    
    func createMessage(_ text: String, sender: UserResponse, reciver: UserResponse,  messageType: MessageType ) {
        let time = Date().timeIntervalSince1970
        let messageKey = _db.collection(_message).document().documentID
        let document = _db.collection(_message)
            .document(sender.id ?? "")
            .collection(reciver.id ?? "")
            .document()
        
        let data: [String: Any] = [
            "text" : text,
            "nameSender" : sender.userName as Any,
            "idSender": sender.id as Any,
            "nameReciver" : reciver.userName as Any,
            "idRecive": reciver.id as Any,
            "timeSend": time,
            "message": messageKey,
            "typeMessage": messageType.type as Any
        ]
        
        document.setData(data)
        let reciverDocument = _db.collection(_message)
            .document(reciver.id ?? "")
            .collection(sender.id ?? "")
            .document()
        
        reciverDocument.setData(data)
    }
    
    func createMessageWithImage(with image: UIImage, sender: UserResponse, reciver: UserResponse, messageType: MessageType) {
        let autoKey = self._db.collection(_message).document().documentID
        let storeRef = Storage.storage().reference()
        let imagekey = NSUUID().uuidString
        let ratioImage = image.size.width / image.size.height
        let time = Date().timeIntervalSince1970
        guard let image = image.jpegData(compressionQuality: 0.4) else {return}
        let imageFolder = storeRef.child(_message).child(imagekey)
        storeRef.child(_message).child(imagekey).putData(image) { [weak self] data, error in
            guard let `self` = self else {return}
            if error != nil {return}
            imageFolder.downloadURL { [weak self] url, error in
                guard let `self` = self else {return}
                if error != nil {return}
                guard let url = url else {return}
                self.imageUrl = "\(url)"
               
                let document = self._db.collection(self._message)
                    .document(sender.id ?? "")
                    .collection(reciver.id ?? "")
                    .document()

                let data: [String: Any] = [
                    "imageUrl" : self.imageUrl,
                    "nameSender" : sender.userName as Any,
                    "idSender": sender.id as Any,
                    "nameReciver" : reciver.userName as Any,
                    "idRecive": reciver.id as Any,
                    "timeSend": time,
                    "message": autoKey,
                    "typeMessage": messageType.type as Any,
                    "ratioImage": ratioImage
                ]
    
                document.setData(data)
                let reciverDocument = self._db.collection(self._message)
                    .document(reciver.id ?? "")
                    .collection(sender.id ?? "")
                    .document()

                reciverDocument.setData(data)
           }
        }
    }
    
    //MARK: FetchMessage
    func fecthMessage(_ sender: UserResponse, reciver: UserResponse, completion: @escaping ([MessageResponse]) -> Void) {
        var _arrayMessage = [MessageResponse]()
        _db.collection(_message).document(sender.id ?? "").collection(reciver.id ?? "").addSnapshotListener { dataSnapShot, error in
            if error != nil { return }
            guard let dataSnapShot = dataSnapShot else {return}
           
            for i in dataSnapShot.documentChanges {
                if i.type == .added || i.type == .removed {
                    let message = MessageResponse(json: i.document.data())
                    if message.idRecive == sender.id ?? "" || message.idRecive == reciver.id ?? "" {
                        _arrayMessage.append(message)
                        _arrayMessage = _arrayMessage.sorted {
                            $0.time ?? 0 < $1.time ?? 0
                        }
                    }
                }
            }
            completion(_arrayMessage)
        }
    }
}
