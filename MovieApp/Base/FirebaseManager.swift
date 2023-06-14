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
    
    func createAccountForstorage(_ email: String, userName: String, id: String) {
        let userData = ["email": email,
                        "userName": userName,
                        "id": id
        ]
        _db.collection(_user).document(id).setData(userData)
        UserDefaultManager.shared.getIdUser(id)
    }
    
    func fecthUserData(_ completion: @escaping (UserResponse) -> Void) {
        let idPath = UserDefaultManager.shared.setIdUser()
        _db.collection(_user).document(idPath).getDocument { dataSnapShot, error in
            let userData = UserResponse.init(json: dataSnapShot?.data() ?? [:])
            completion(userData)
        }
    }
}
