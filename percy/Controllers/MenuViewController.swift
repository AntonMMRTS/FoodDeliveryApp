import UIKit

class MenuViewController: UIViewController {

    var menu: Menu!
    
    let categoryNames = ["soup" : "Супы", "pizza" : "Пицца", "hot" : "Горячее", "lasagna" : "Лазанья", "pasta" : "Паста", "salad" : "Салаты"]
   
    let categories = ["pizza", "pasta", "lasagna", "salad", "hot", "soup"]
    
    var indexCounter = 0
    
    var selectedGroupIndex = 0
    
    var menuView = MenuView()
    
    let firebaseManager = FirebaseManager()
    
    override func loadView() {
       self.view = menuView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        menu = Menu()
      

        menuView.setupCategoryCollectionView()
        
        navigationItemSettings()
        
        fetchMenu(index: indexCounter)
//        getMenu()
        
        menuView.categoryCollectionView.dataSource = self
        menuView.categoryCollectionView.delegate = self
        
        menuView.menuCollectionView.dataSource = self
        menuView.menuCollectionView.delegate = self
    }

    private func navigationItemSettings() {
 
        let imageView = UIImageView(image: UIImage(named: "percy"))
//        imageView.frame = CGRect(x: 0, y: 0, width: 112, height: 24)
        imageView.contentMode = .scaleAspectFill
        
        navigationItem.titleView = imageView
  
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == menuView.categoryCollectionView {
            return menu.products.count
           
        } else {
            guard menu.products.count != 0 else { return 0 }
            let group = menu.products[selectedGroupIndex]
            return group.products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == menuView.categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier,
                                                          for: indexPath) as! CategoryCell
            
            let categoryName = menu.products[indexPath.item].name
            

            cell.setupCell(category: categoryName)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier,
                                                          for: indexPath) as! MenuCell
            cell.backgroundColor = .black
            let group = menu.products[selectedGroupIndex]
            let product = group.products[indexPath.item]

            cell.product = product
           
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuView.categoryCollectionView {
        
            self.selectedGroupIndex = indexPath.item
            print(selectedGroupIndex)
            
            // при переходи скролим с первой картинки
//            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
//                                             at: .left,
//                                             animated: false)
            
            menuView.menuCollectionView.reloadData()
        } else {
            let vc = ProductDetailViewController()
            let newProduct = menu.products[selectedGroupIndex].products[indexPath.item]
            vc.product = newProduct
            navigationController?.pushViewController(vc, animated: true)
                }
    }

}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    
    // задаем размеры нашей ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == menuView.categoryCollectionView {
            let categoryName = menu.products[indexPath.row].name
           
            
            let width = categoryName.widthOfString(
                usingFont: UIFont(name: "HelveticaNeue-Medium", size: 23) ??  UIFont.systemFont(ofSize: 23))
            
            return CGSize(width: width + 20,
                          height: collectionView.frame.height)
        } else {
            return CGSize(width: UIScreen.main.bounds.width/2 - 10,
                          height: (UIScreen.main.bounds.width/2 - 10) * 7 / 4)
        }
    }
    
    // уберем отступ между ячейками
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
    
    // делаем отступы между ячейками, не нарушая центровки
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//    }
    
}
