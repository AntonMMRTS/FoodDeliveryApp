import UIKit
import SDWebImage

class MenuViewController: UIViewController {

    // MARK:- Public properties
    var menu: Menu!
    
    let categoryNames = ["soup" : "Супы", "pizza" : "Пицца", "hot" : "Горячее", "lasagna" : "Лазанья", "pasta" : "Паста", "salad" : "Салаты"]
   
    let categories = ["pizza", "pasta", "lasagna", "salad", "hot", "soup"]
    
    var indexCounter = 0
    
    var selectedGroupIndex = 0
    
    var menuView = MenuView()
    
    let firebaseManager = FirebaseManager()
    
    // MARK: - Inicializations
    override func loadView() {
       self.view = menuView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        menu = Menu()

        navigationItemSettings()
        
        signinButton()
        
//        fetchMenu(index: indexCounter)

        menuView.categoryCollectionView.dataSource = self
        menuView.categoryCollectionView.delegate = self
        
        menuView.menuCollectionView.dataSource = self
        menuView.menuCollectionView.delegate = self
    }
    
    // MARK: - Private methods
    private func navigationItemSettings() {
 
        let imageView = UIImageView(image: UIImage(named: "percy"))
        imageView.contentMode = .scaleAspectFill
        
        navigationItem.titleView = imageView
  
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func signinButton() {
        let signInButton = UIBarButtonItem(title: "SignIn", style: .done, target: self, action: #selector(showAdminMenu))
        signInButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = signInButton
    }
    
    @objc private func showAdminMenu() {
        let vc = AdminViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - extensions UICollectionViewDataSource, UICollectionViewDelegate
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
            
            if selectedGroupIndex == indexPath.item {
                cell.categoryFoodLabel.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 25)
                cell.categoryFoodLabel.alpha = 1
            } else {
                cell.categoryFoodLabel.font = UIFont(name: "HelveticaNeue-MediumItalic", size: 23)
                cell.categoryFoodLabel.alpha = 0.8
            }
            
            cell.setupCell(category: categoryName)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier,
                                                          for: indexPath) as! MenuCell
            cell.backgroundColor = .black
            let group = menu.products[selectedGroupIndex]
            let product = group.products[indexPath.item]

            cell.product = product

            let databaseManager: DatabaseManagerProtocol = RealmManager()
            cell.closure = {
                self.tabBarController?.tabBar.items?.last?.badgeValue = "\(databaseManager.obtainProducts().count)"
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuView.categoryCollectionView {
            
            self.selectedGroupIndex = indexPath.item
            menuView.categoryCollectionView.reloadData()
            
            menuView.menuCollectionView.reloadData()
        } else {
            let vc = ProductDetailViewController()
            let newProduct = menu.products[selectedGroupIndex].products[indexPath.item]
            vc.product = newProduct
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

// MARK: - extensions UICollectionViewDelegateFlowLayout
extension MenuViewController: UICollectionViewDelegateFlowLayout {
    
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
    
}
