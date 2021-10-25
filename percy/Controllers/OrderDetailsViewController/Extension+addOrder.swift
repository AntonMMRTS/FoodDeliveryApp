//
//  Extension+addOrder.swift
//  percy
//
//  Created by Антон Усов on 17.08.2021.
//

import Foundation

extension OrderDetailsViewController {
    
    
    
    @objc func addOrder() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        myOrderManager.addNewOrder(products: products, sumPrice: totalSum)
        
        let dbDestination = self.db.collection("users")
            .document(currentUser!.phoneNumber!)
            .collection("orders")
            .document(formatter.string(from: Date()))
        
//        dbDestination.setData(["date" : formatter.string(from: Date()), "sum" : totalSum!, "adress" : orderView.addressTetxField.text!])

        for product in products {

            dbDestination.collection("order")
                .document(product.name + " \(product.quantity) шт")
                .setData(["name" : product.name, "amount" : product.quantity])

            db.collection("orders")
                .document(currentUser!.phoneNumber!)
                .collection("order")
                .document(product.name + " \(product.quantity) шт")
                .setData(["name" : product.name, "amount" : product.quantity])

            databaseManager.deleteProduct(product: product)
        }
        
        db.collection("orders")
            .document(currentUser!.phoneNumber!)
            .setData([
//                        "adress" : orderView.addressTetxField.text!,
                        "comment" : orderView.commentTetxField.text!,
                        "persons" : 2,
                        "sum" : totalSum!,
                        "time" : "now",
                        "date" : formatter.string(from: Date()),
                        "phone" : currentUser!.phoneNumber!])
        
        tabBarController?.tabBar.items?.last?.badgeValue = nil
        print("You did order")
    }
}
