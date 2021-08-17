import UIKit

extension MenuViewController {
    
    func fetchMenu(index: Int) {
        
        self.firebaseManager.getSubMenu(category: self.categories[index],
                                        name: categoryNames[categories[index]]!,
                                        collectionView: self.menuView.menuCollectionView) {
            [weak self] newCategory in
            self?.menu.products.append(newCategory)
            
            self?.indexCounter += 1
            
            guard index != self!.categories.count - 1 else {
                self?.menuView.categoryCollectionView.reloadData()
                return }
            
            self?.fetchMenu(index: self!.indexCounter)
        }
    }
    
    func getMenu() {
        //        let currentTime = CFAbsoluteTimeGetCurrent()
        let categoryNames = ["soup" : "Супы", "pizza" : "Пицца", "hot" : "Горячее", "lasagna" : "Лазанья", "pasta" : "Паста", "salad" : "Салаты"]
        
        let categories = ["pizza", "pasta", "lasagna", "salad", "hot", "soup"]
        
        for i in categories {
            self.firebaseManager.getSubMenu(category: i, name: categoryNames[i]!, collectionView: self.menuView.menuCollectionView) { (newCategory) in
                self.menu.products.append(newCategory)
                self.menuView.categoryCollectionView.reloadData()
            }
        }
        //        print(currentTime - CFAbsoluteTimeGetCurrent())
    }
}
