//
//  MyOrderRealmManager.swift
//  percy
//
//  Created by Антон Усов on 18.08.2021.
//

import Foundation
import RealmSwift


class MyOrderRealmManager {
    
    fileprivate lazy var realm = try! Realm(configuration: .defaultConfiguration)
    
    func addNewOrder (products: [Product], sumPrice: Int) {
        
        let myProducts = List<MyProduct>()
        
        for i in products {
            let myProduct = MyProduct()
            myProduct.name = i.name
            myProduct.price = i.price
            myProduct.quantity = i.quantity
            myProducts.append(myProduct)
        }
        
        let myOrder = MyOrder()
        
        myOrder.sumPrice = sumPrice
        myOrder.products = myProducts
        
        try! realm.write {
            realm.add(myOrder)
        }
    }
    
    func obtainOrders() -> Results<MyOrder> {
        let models = realm.objects(MyOrder.self)
        return models
    }
}
