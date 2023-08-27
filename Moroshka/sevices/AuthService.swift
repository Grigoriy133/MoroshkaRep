//
//  AuthService.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 18.08.2023.
//

import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    let adminId = "Ag7sNEl4JJXKacs8C0y2QqxgFyo1"
    
    private init() {}
    
     private let auth = Auth.auth()
    
     var currentUser: User? {
        return auth.currentUser
    }
    
    func registrate(email: String,
                    password: String,
                    completion: @escaping (Result<User, Error>) -> ()) {
        
        auth.createUser(withEmail: email,
                        password: password){ result, error in
            
            if let result = result {
                let newUser = UserModel(id: result.user.uid,
                                        name: "",
                                        phone: "",
                                        adress: "")
                
                DatabaseService.shared.setUser(user: newUser) { resultDB in
                    switch resultDB  {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }

            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> ()) {
        
        auth.signIn(withEmail: email, password: password){ result, error in
        
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
    }
    func signOut(){
       try! auth.signOut()
    }
}
