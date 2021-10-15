import Foundation
import RealmSwift


protocol DatabaseManagerProtocol {
    
    func addNewProduct (product: Product)
    
    func updateProductStart()
    
    func updateProductEnd()
    
    func obtainProducts() -> [Product]
    
    func deleteProduct (product:Product)
    
    func deleteAll()
}

class RealmManager: DatabaseManagerProtocol {
    
    fileprivate lazy var realm = try! Realm(configuration: .defaultConfiguration)
    
    func addNewProduct (product: Product) {
        let newProduct = Product()
        
        newProduct.name = product.name
        newProduct.price = product.price
        newProduct.image = product.image
        newProduct.quantity = product.quantity
        
        try! realm.write {
            realm.add(newProduct)
        }
    }
    
    func updateProductStart() {
        realm.beginWrite()
    }
    
    func updateProductEnd() {
        try? realm.commitWrite()
    }
    
    func obtainProducts() -> [Product] {
        let models = realm.objects(Product.self)
        return Array(models)
    }
    
    func deleteProduct (product:Product) {
        try? realm.write {
            realm.delete(product)
        }
    }
    
    func deleteAll() {
        realm.deleteAll()
    }
    
}
