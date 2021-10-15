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
    
}
