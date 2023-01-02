//
//  SettingsVC.swift
//  BookComment
//
//  Created by Talha Gölcügezli on 29.12.2022.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    @IBOutlet weak var darkMode: UISwitch!
    var switchBool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        darkMode.setOn(false, animated: true)
    }
    

    @IBAction func darkSwitch(_ sender: Any) {
        if darkMode.isOn {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
                switchBool = true
                darkMode.setOn(switchBool, animated: true)
            }
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
                switchBool = false
                darkMode.setOn(switchBool, animated: true)
            }
        }
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toSignInVC", sender: nil)
        }catch {
            print("Error!")
        }
    }
}
