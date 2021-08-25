//
//  AdminOrderManager.swift
//  percy
//
//  Created by Антон Усов on 25.08.2021.
//

import UIKit
import Firebase

class AdminOrderManager {
    
    private var db = Firestore.firestore()
    
    func getOrders(tableView: UITableView, completion: @escaping ([AdminOrder]) -> Void) {
        
        var allOrders: [AdminOrder] = []
        
        self.db.collection("orders").getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let orders = snapshot else { return }
                
                for order in orders.documents {
                    
                    let address = order["adress"] as! String
                    let comment = order["comment"] as! String
                    let date = order["date"] as! String
                    let phone = order["phone"] as! String
                    let totalPrice = order["sum"] as! Int
                    let deliveryTime = order["time"] as! String
                    
                    let newOrder = AdminOrder()
                    
                    newOrder.address = address
                    newOrder.comment = comment
                    newOrder.date = date
                    newOrder.phone = phone
                    newOrder.totalPrice = totalPrice
                    newOrder.deliveryTime = deliveryTime
                    
                    self.getMiniOrder(phone: phone) { (newMiniOrder) in
                        newOrder.order = newMiniOrder
                        tableView.reloadData()
                    }
                    
                    allOrders.append(newOrder)
                }
            }
            completion(allOrders)
        }
    }
    
    func getMiniOrder(phone: String, completion: @escaping ([MiniOrder]) -> Void) {
        
        self.db.collection("orders").document(phone).collection("order").getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let miniOrders = snapshot else { return }
                
                var miniOrder: [MiniOrder] = []
                
                for i in miniOrders.documents {
                    let amount = i["amount"] as! Int
                    let name = i["name"] as! String
                    
                    let newMiniOrder = MiniOrder()
                    
                    newMiniOrder.amount = amount
                    newMiniOrder.name = name
                    
                    miniOrder.append(newMiniOrder)
                }
                completion(miniOrder)
            }
        }
    }
}
