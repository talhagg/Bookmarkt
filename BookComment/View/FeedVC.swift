//
//  FeedVC.swift
//  BookComment
//
//  Created by Talha Gölcügezli on 29.12.2022.
//

import UIKit
import SDWebImage
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let firestore = Firestore.firestore()
    var bookArray = [Book]()
    var feedViewModel = FeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirebase()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.usernameLabel.text = self.bookArray[indexPath.row].bookName
        cell.bookNameLabel.text = self.bookArray[indexPath.row].comment
        cell.commentLabel.text = self.bookArray[indexPath.row].username
        cell.cellImageView.sd_setImage(with: URL(string: self.bookArray[indexPath.row].imageUrl))
        return cell
    }
    
    
    func getDataFromFirebase() {
        feedViewModel.getDataFirebase { snapshot in
            if snapshot?.isEmpty == false && snapshot != nil {
                self.bookArray.removeAll(keepingCapacity: false)
                for document in snapshot!.documents {
                    let documentId = document.documentID
                    
                    if let bookName = document.get("bookName") as? String {
                        if let comment = document.get("comment") as? String {
                            if let imageData = document.get("imageUrl") as? String {
                                if let postedBy = document.get("postedBy") as? String {
                                    let book = Book(username: postedBy, bookName: bookName, comment: comment, imageUrl: imageData, documentId: documentId)
                                    
                                    self.bookArray.append(book)
                                }
                            }
                        }
                    }
                }
                self.tableView.reloadData()
            } else {
                self.makeAlert(titleInput: "Error", messageInput: "Is empty!")
            }
        }
    }
     
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userEmail = bookArray[indexPath.row].username
            if userEmail == Auth.auth().currentUser?.email {
                let dataId = bookArray[indexPath.row].documentId
                firestore.collection("Book").document(dataId).delete()
                bookArray.remove(at: indexPath.row)
                self.tableView.reloadData()
            } else {
                self.makeAlert(titleInput: "Error", messageInput: "Sorry, you are unable to delete this. You can only delete posts that you have added yourself.")
            }
        }
    }

    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK!", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    


}
