//
//  FirebaseSaleManager.swift
//  percy
//
//  Created by Антон Усов on 25.08.2021.
//

import Firebase
import SDWebImage

class FirebaseSaleManager {
    
    private var db = Firestore.firestore()
    
    private let imageManager = StorageManager()
    
    func getSales(tableView: UITableView, completion: @escaping ([Sale]) -> Void) {
        
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
                    
                    let storage = Storage.storage()
                    let reference = storage.reference()
                    let pathRef = reference.child("sales")
                    let fileRef = pathRef.child(imageName + ".jpg")
                    
                    fileRef.downloadURL { (url, error) in
                        guard error == nil else { return }
                        guard let url = url else { return }
                        
                        newSale.saleURL = "\(url)"
                        
                        tableView.reloadData()
                    }
                    allSales.append(newSale)
                }
            }
            completion(allSales)
        }
    }
}
