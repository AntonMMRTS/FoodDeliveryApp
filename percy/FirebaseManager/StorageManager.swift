//
//  StorageManager.swift
//  percy
//
//  Created by Антон Усов on 30.07.2021.
//

import UIKit
import FirebaseStorage

class StorageManager {
    
    func getImage(picName: String, categorie: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child(categorie)
        
        var image: UIImage = UIImage(named: "default")!
        
        let fileRef = pathRef.child(picName + ".jpg")
        
        fileRef.getData(maxSize: 1024*1024) { (data, error) in
            guard error == nil else { completion(image);
                print(error!.localizedDescription)
                return }
            image = UIImage(data: data!)!
            print(picName)
            completion(image)
        }
    }
    
}
