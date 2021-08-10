import UIKit
import Firebase

class FirebaseManager {
    
    private var db = Firestore.firestore()
    
    func getSubMenu(category: String, name: String, collectionView: UICollectionView, completion: @escaping (ProductCategory) -> Void) {
//        let time = CFAbsoluteTimeGetCurrent()
        self.getData(collection: category) { (newProducts) in
            let newCategory = ProductCategory(name: name, products: newProducts)
            
            for i in newProducts {
                i.image = UIImage(named: "default")!
                self.getImage(picName: i.imageName, categorie: i.category) { (newImage) in
                    i.image = newImage
                    collectionView.reloadData()
//                    print(time - CFAbsoluteTimeGetCurrent())
//                    print(i.imageName)
                }
            }
            completion(newCategory)
        }
    }
    
//    func getSales(tableView: UITableView, completion: @escaping ([Sale]) -> Void) {
//
//        var allSales: [Sale] = []
//
//        self.db.collection("sales").getDocuments { (snapshot, error) in
//            if let err = error {
//                debugPrint("Error fetching docs: \(err)")
//            } else {
//                guard let sales = snapshot else { return }
//
//                for sale in sales.documents {
//                    let shortDefinition = sale["shortDefinition"] as! String
//                    let longDefinition = sale["longDefinition"] as! String
//                    let imageName = sale["imageName"] as! String
//
//                    var newSale = Sale(shortDefinition: shortDefinition, longDefinition: longDefinition)
//
//                    self.getImage(picName: imageName, categorie: "sales") { (newImage) in
//                        newSale.image = newImage
//
//                        print(imageName)
//                        print(newImage)
//                        allSales.append(newSale)
//                        tableView.reloadData()
//                    }
//                }
//            }
//            completion(allSales)
//        }
//    }
    
    func sales(tableView: UITableView, completion: @escaping ([Sale]) -> Void) {
        
        getSales { sales in
            for i in sales {
                i.image = UIImage(named: "default")!
                self.getImage(picName: i.imageName, categorie: "sales") { (newImage) in
                    i.image = newImage
//                    if i == sales.last {
                        tableView.reloadData()
//                    }
                }
            }
            completion(sales)
        }
    }
    
    func getSales(completion: @escaping ([Sale]) -> Void) {
        
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
    
    private func getImage(picName: String, categorie: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child(categorie)
        
        var image: UIImage = UIImage(named: "default")!
        
        let fileRef = pathRef.child(picName + ".jpg")
        
        fileRef.getData(maxSize: 1024*1024) { (data, error) in
            guard error == nil else { completion(image);
                print(error!.localizedDescription)
                return }
            image = UIImage(data: data!)!
            completion(image)
        }
    }

}
