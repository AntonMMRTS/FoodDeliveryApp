//
//  FirebaseSaleManager.swift
//  percy
//
//  Created by Антон Усов on 25.08.2021.
//

import UIKit
import Firebase

class FirebaseSaleManager {
    
    private var db = Firestore.firestore()
    
    private let imageManager = StorageManager()
    
    func getSales(tableView: UITableView, completion: @escaping ([Sale]) -> Void) {
        
        getSalesWithoutImages { [weak self] sales in
            for i in sales {
                i.image = UIImage(named: "default")!
                self?.imageManager.getImage(picName: i.imageName, categorie: "sales") { newImage in
                    i.image = newImage
                    tableView.reloadData()
                }
            }
            completion(sales)
        }
    }
    
    func getSalesWithoutImages(completion: @escaping ([Sale]) -> Void) {
        
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
                    newSale.image = UIImage(named: "default")!
                    
                    allSales.append(newSale)
                }
            }
            completion(allSales)
        }
    }
}
