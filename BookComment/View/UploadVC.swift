//
//  UploadVC.swift
//  BookComment
//
//  Created by Talha Gölcügezli on 29.12.2022.
//

import UIKit
import Firebase

class UploadVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var bookNameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    
    private let uploadViewModel = UploadViewModel()
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picker.delegate = self
        uploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getPhotos(_:)))
        uploadImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[.mediaType] as? String
                switch mediaType {
                case "public.movie":
                    if let videoUrl = info[.mediaURL] as? NSURL {
                        // TODO : set video to avplayer
                        print(videoUrl)
                    }
                case "public.image":
                    if let image = info[.originalImage] as? UIImage {
                        uploadImageView.image = image
                    }
                default:
                    break
                }
                self.dismiss(animated: true)
            
    }
    
    @objc func getPhotos(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
               
               let btnCamera = UIAlertAction(title: "Camera", style: .default) { (action) in
                   self.picker.sourceType = .camera
                   self.present(self.picker, animated: true)
               }
               
               let btnGallery = UIAlertAction(title: "Gallery", style: .default) { (action) in
                   self.picker.sourceType = .photoLibrary
                   self.present(self.picker, animated: true)
               }
               
               let btnCancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
                   
               }
               optionMenu.addAction(btnCamera)
               optionMenu.addAction(btnGallery)
               optionMenu.addAction(btnCancel)
               self.present(optionMenu, animated: true)
           
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
        if bookNameText.text != "" && commentText.text != "" {
            let firestorePost = ["postedBy":Auth.auth().currentUser?.email,"bookName":self.bookNameText.text!,"comment":self.commentText.text!,"date":FieldValue.serverTimestamp()] as [String: Any]
            uploadViewModel.uploadData(image: uploadImageView, post: firestorePost) { result in
                if result {
                    self.uploadImageView.image = UIImage(named: "storyBook")
                    self.bookNameText.text = ""
                    self.commentText.text = ""
                    self.tabBarController?.selectedIndex = 0
                } else {
                    self.makeAlert(titleInput: "Error!", messageInput: "error!")
                }
            }
        } else {
            self.makeAlert(titleInput: "Error!", messageInput: "Bookname/Comment Text is empty!")
        }
       
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK!", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}
