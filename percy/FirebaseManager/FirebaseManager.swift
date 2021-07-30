import UIKit
import Firebase
//import FirebaseStorage
//import FirebaseDatabase

class FirebaseManager {
    
//    static let shared = FirebaseManager()
    private var db = Firestore.firestore()
    
//    private func configureFB() -> Firestore {
//
//        var db: Firestore!
//        let settings = FirestoreSettings()
//        Firestore.firestore().settings = settings
//        db = Firestore.firestore()
//        return db
//    }
    
    func getData(collection: String, completion: @escaping ([Product]) -> Void) {
//        let db = configureFB()
        var newProducts: [Product] = []
        db.collection(collection).getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }

                for product in snap.documents {
                    let name = product["name"] as! String
                    let price = product["price"] as! Int
                    let imageName = product["imageName"] as! String
                    let definition = product["definition"] as! String
                    let weight = product["weight"] as! String
                    let halories = product["halories"] as! String
                    let energyValue = product["energyValue"] as! String
                    let category = product["category"] as! String

                    let newProduct = Product()
                    newProduct.name = name
                    newProduct.price = price
                    newProduct.imageName = imageName
                    newProduct.definition = definition
                    newProduct.weight = weight
                    newProduct.halories = halories
                    newProduct.energyValue = energyValue
                    newProduct.category = category

                    newProducts.append(newProduct)
                }
            }
            completion(newProducts)
        }
    }
//    func getData(collection: String) -> [Product] {
////        let db = configureFB()
//        var newProducts: [Product] = []
//        db.collection(collection).getDocuments { (snapshot, error) in
//            if let err = error {
//                debugPrint("Error fetching docs: \(err)")
//            } else {
//                guard let snap = snapshot else { return }
//
//                for product in snap.documents {
//                    let name = product["name"] as! String
//                    let price = product["price"] as! Int
//                    let imageName = product["imageName"] as! String
//                    let definition = product["definition"] as! String
//                    let weight = product["weight"] as! String
//                    let halories = product["halories"] as! String
//                    let energyValue = product["energyValue"] as! String
//                    let category = product["category"] as! String
//
//                    let newProduct = Product()
//                    newProduct.name = name
//                    newProduct.price = price
//                    newProduct.imageName = imageName
//                    newProduct.definition = definition
//                    newProduct.weight = weight
//                    newProduct.halories = halories
//                    newProduct.energyValue = energyValue
//                    newProduct.category = category
//
//                    newProducts.append(newProduct)
//                }
//            }
//        }
//        return newProducts
//    }
}
