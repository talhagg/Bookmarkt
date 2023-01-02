//
//  UploadViewModel.swift
//  BookComment
//
//  Created by Talha Gölcügezli on 30.12.2022.
//

import Foundation
import UIKit
import Firebase

struct UploadViewModel {
    let firestore = Firestore.firestore()
}

extension UploadViewModel {
    func uploadData(image: UIImageView,post: [String: Any], completion: @escaping (Bool) -> ())  {
        var uploadPost : [String:Any] = post
        let storage = Storage.storage()
        let mediaFolder = storage.reference().child("media")
        
        if let imageData = image.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID()
            let imageReferance = mediaFolder.child("\(uuid).jpeg")
            
            imageReferance.putData(imageData) { storageData, error in
                if error != nil {
                    completion(false)
 
                } else {
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let firestore = Firestore.firestore()
                            
                            uploadPost["imageUrl"] = imageUrl
                            
                            firestore.collection("Book").addDocument(data: uploadPost,completion: { error in
                                if error != nil {
                                    completion(false)
                                } else {
                                    completion(true)
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}
