//
//  FirebaseManager.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    private let _db = Firestore.firestore()
    private var _ref: DocumentReference? = nil
    private let _user = "User"
    private let _message = "Message"
    private var _arrayUser = [UserResponse]()
    
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
    
    func createMessage(_ text: String, sender: UserResponse, reciver: UserResponse) {
        let time = Date().timeIntervalSince1970
        let messageKey = _db.collection(_message).document().documentID
        let document = _db.collection(_message)
            .document(sender.id ?? "")
            .collection(reciver.id ?? "")
            .document()
        
        let data: [String: Any] = [
            "text" : text,
            "nameSender" : sender.userName as Any,
            "nameReciver" : reciver.userName as Any,
            "timeSend": time,
            "message": messageKey
        ]
        document.setData(data)
        let reciverDocument = _db.collection(_message)
            .document(reciver.id ?? "")
            .collection(sender.id ?? "")
            .document()
        
        reciverDocument.setData(data)
    }
    
    func fecthMessage(_ sender: UserResponse, reciver: UserResponse) {
        
    }
}
