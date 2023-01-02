//
//  SignUpVC.swift
//  BookComment
//
//  Created by Talha Gölcügezli on 29.12.2022.
//

import UIKit


class SignUpVC: UIViewController {

    @IBOutlet weak var signUpImageView: UIImageView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var retryPasswordText: UITextField!
    
    let signUpViewModel = SignUpViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signUpImageView.image = UIImage(named: "signUpBook")
    }
    

    @IBAction func signUpClicked(_ sender: Any) {
        if usernameText.text != "" && emailText.text != "" && passwordText.text != "" && retryPasswordText.text != "" {
            if passwordText.text == retryPasswordText.text {
                let emailTextInput = String(emailText.text!)
                let passwordTextInput = String(passwordText.text!)
                let usernameTextInput = String(usernameText.text!)
              
                signUpViewModel.signUpCompleted(emailInput: emailTextInput, passwordInput: passwordTextInput,usernameInput: usernameTextInput) { control in
                    if control {
                        self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                    } else {
                        self.makeAlert(titleInput: "Error!", messageInput: "Error")
                    }
                }
            } else {
                self.makeAlert(titleInput: "Error!", messageInput: "Password is not matches!")
            }
        } else {
            self.makeAlert(titleInput: "Error!", messageInput: "Is not empty!")
        }
    }
    
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK!", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    

}
