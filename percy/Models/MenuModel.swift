import UIKit

class Menu {
    var products = [ProductCategory]()
    
    init() {
        let firebaseManager = FirebaseManager()
        
        firebaseManager.getData(collection: "hot") { (newProducts) in
        let hot = ProductCategory(name: "Горячее", products: newProducts)
            self.products.append(hot)
        }
        
        firebaseManager.getData(collection: "soup") { (newProducts) in
        let soup = ProductCategory(name: "Супы", products: newProducts)
            self.products.append(soup)
        }
    }
    
}
