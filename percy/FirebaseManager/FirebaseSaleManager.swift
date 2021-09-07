//
//  FirebaseSaleManager.swift
//  percy
//
//  Created by Антон Усов on 25.08.2021.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class FirebaseSaleManager {
    
    private var db = Firestore.firestore()
    
    private let imageManager = StorageManager()
    
//    func getSales(tableView: UITableView, completion: @escaping ([Sale]) -> Void) {
//        
//        getSalesWithoutImages { [weak self] sales in
//            for i in sales {
//                i.image = UIImage(named: "default")!
//                self?.imageManager.getImage(picName: i.imageName, categorie: "sales") { newImage in
//                    i.image = newImage
//                    tableView.reloadData()
//                }
//            }
//            completion(sales)
//        }
//    }
    
    func getSalesWithoutImages(tableView: UITableView, completion: @escaping ([Sale]) -> Void) {
        
        var allSales: [Sale] = []
        
        self.db.collection("sales").getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let sales = snapshot else { return }
                
                for sale in sales.documents {
                    let shortDefinition = sale["shortDefinition"] as! String
                    let longDefinition = sale["longDefinition"] as! String
                    let imageName = sale["imageName"] as! String
                    
                    let newSale = Sale()
                    newSale.longDefinition = longDefinition
                    newSale.shortDefinition = shortDefinition
                    newSale.imageName = imageName
//                    newSale.image = UIImage(named: "default")!
                    
                    let storage = Storage.storage()
                    let reference = storage.reference()
                    let pathRef = reference.child("sales")
                    
                    let fileRef = pathRef.child(imageName + ".jpg")
                    fileRef.downloadURL { (url, error) in
                        guard error == nil else { return }
                        guard let url = url else { return }
                        newSale.saleURL = "\(url)"
                        
//                        let saleImageView = UIImageView()
//                        saleImageView.sd_setImage(with: URL(string: newSale.saleURL), placeholderImage: UIImage(named: "default"), options: []) { (uiimage, error, cashe, url) in
//                            guard uiimage != nil else {
//                                print("hi")
//                                return }
//                            newSale.image = uiimage!
//                            tableView.reloadData()
//                        }
                        
                        tableView.reloadData()
                    }
                    
                    allSales.append(newSale)
                }
            }
            completion(allSales)
        }
    }
}
