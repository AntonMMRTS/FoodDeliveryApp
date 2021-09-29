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
        try! realm.write {
            realm.add(product)
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
