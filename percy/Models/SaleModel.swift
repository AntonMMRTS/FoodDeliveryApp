//
//  SaleModel.swift
//  percy
//
//  Created by Антон Усов on 09.08.2021.
//

import UIKit

class Sale: Equatable {
    static func == (lhs: Sale, rhs: Sale) -> Bool {
        if lhs.image == rhs.image &&
            lhs.shortDefinition == rhs.shortDefinition &&
            lhs.imageName == rhs.imageName &&
            lhs.longDefinition == rhs.longDefinition {
            return true
        }
        return false
    }
    
    var image = UIImage()
    var shortDefinition: String = ""
    var longDefinition: String = ""
    var imageName = ""
}
