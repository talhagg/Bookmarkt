//
//  FeedViewModel.swift
//  BookComment
//
//  Created by Talha Gölcügezli on 30.12.2022.
//

import Foundation
import Firebase




struct FeedViewModel {
    let firestore = Firestore.firestore()
}

extension FeedViewModel {
    func getDataFirebase(completion: @escaping (QuerySnapshot?) -> ())  {
        firestore.collection("Book").addSnapshotListener { snapshot, error in
            if error != nil {
                completion(nil)
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    completion(snapshot)
                }
            }
        }  
    }
}




