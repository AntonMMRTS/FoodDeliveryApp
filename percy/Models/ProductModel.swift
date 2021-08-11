import UIKit
import RealmSwift

class Product: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var imageName: String = ""
    @objc dynamic var definition: String = ""
    @objc dynamic var weight: String = ""
    @objc dynamic var halories: String = ""
    @objc dynamic var energyValue: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var quantity: Int = 1
    @objc dynamic var image:  Data = Data()
}
//class Product {
//    var name: String = ""
//    var price: Int = 0
//    var imageName: String = ""
//    var definition: String = ""
//    var weight: String = ""
//    var halories: String = ""
//    var energyValue: String = ""
//    var category: String = ""
//    var quantity: Int = 1
//    var image: Data = Data()
//}
