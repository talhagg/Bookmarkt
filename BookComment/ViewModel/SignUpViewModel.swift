//
//  SignUpViewModel.swift
//  BookComment
//
//  Created by Talha Gölcügezli on 1.01.2023.
//

import Foundation
import Firebase

struct SignUpViewModel {
    let firestore = Firestore.firestore()
}

extension SignUpViewModel {
    func signUpCompleted(emailInput:String,passwordInput: String, usernameInput: String, completion: @escaping (Bool) ->()) {
        Auth.auth().createUser(withEmail: emailInput, password: passwordInput) { auth, error in
            if error != nil {
                completion(false)
            } else {
                let userDictinory = ["email": emailInput,"username": usernameInput] as [String: Any]
                
                firestore.collection("UserInfo").addDocument(data: userDictinory) { error in
                    if error != nil {
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        }
        
    }
}
