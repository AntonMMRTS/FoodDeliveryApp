//
//  AdminOrder.swift
//  percy
//
//  Created by Антон Усов on 25.08.2021.
//

import Foundation


struct AdminOrder {
    var order: [MiniOrder] = []
    var address: String = ""
    var comment: String = ""
    var date: String = ""
    var phone: String = ""
    var totalPrice: Int = 0
    var deliveryTime: String = ""
}

struct MiniOrder {
    var amount = 1
    var name = ""
}
