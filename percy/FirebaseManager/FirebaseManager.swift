import UIKit
import Firebase

class FirebaseManager {
    
    private var db = Firestore.firestore()
    
    private let imageManager = StorageManager()
    
    func getSubMenu(category: String, name: String, collectionView: UICollectionView, completion: @escaping (ProductCategory) -> Void) {
//        let time = CFAbsoluteTimeGetCurrent()
        self.getData(collection: category) { [weak self] newProducts in
            let newCategory = ProductCategory(name: name, products: newProducts)
            
            for i in newProducts {
                i.image = UIImage(named: "default")!.jpegData(compressionQuality: 1)!
                self?.imageManager.getImage(picName: i.imageName, categorie: i.category) { (newImage) in
                    i.image = newImage.jpegData(compressionQuality: 1)!
                    collectionView.reloadData()
//                    print(time - CFAbsoluteTimeGetCurrent())
//                    print(i.imageName)
                }
            }
            completion(newCategory)
        }
    }

    private func getData(collection: String, completion: @escaping ([Product]) -> Void) {
        
        var newProducts: [Product] = []
        
        self.db.collection(collection).getDocuments { (snapshot, error) in
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

}
