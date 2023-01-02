//
//  ViewController.swift
//  BookComment
//
//  Created by Talha Gölcügezli on 28.12.2022.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var signImageView: UIImageView!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signImageView.image = UIImage(named: "book")
        
    }
    

    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    
    @IBAction func resetToPassword(_ sender: Any) {
        if emailText.text != "" {
            Auth.auth().sendPasswordReset(withEmail: emailText.text!) { error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.makeAlert(titleInput: "Success", messageInput: "New password to email send!")
                }
            }
        } else {
            self.makeAlert(titleInput: "Error!", messageInput: "Email Text Is Empty!")
        }
     
    }
    
    
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK!", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

