//
//  MyOrderModel.swift
//  percy
//
//  Created by Антон Усов on 18.08.2021.
//

import Foundation
import RealmSwift

class MyOrder: Object {
    @objc dynamic var date: Date = Date()
    @objc dynamic var sumPrice: Int = 0
    var products = List<MyProduct>()
}

class MyProduct: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var quantity: Int = 1
}
