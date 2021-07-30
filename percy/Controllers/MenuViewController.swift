import UIKit

class MenuViewController: UIViewController {
  
    var menu: Menu!
    
    var categoryCollectionView: UICollectionView!
    var menuCollectionView: UICollectionView!
    
    var selectedGroupIndex = 0
    
    let storageManager = StorageManager()
    let firebaseManager = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menu = Menu()

        navigationController?.navigationBar.barStyle = .black
        setupCategoryCollectionView()
        setupMenuCollectionView()

        self.firebaseManager.getData(collection: "hot") { (newProducts) in
            let hot = ProductCategory(name: "Горячее", products: newProducts)
            
            for i in newProducts {
                self.storageManager.getImage(picName: i.imageName, categorie: i.category) { (newImage) in
                    i.image = newImage
                    self.menuCollectionView.reloadData()
                }
            }
            self.menu.products.append(hot)
            self.categoryCollectionView.reloadData()
        }
        
        firebaseManager.getData(collection: "soup") { (newProducts) in
            let soup = ProductCategory(name: "Супы", products: newProducts)
            
            for i in newProducts {
                self.storageManager.getImage(picName: i.imageName, categorie: i.category) { (newImage) in
                    i.image = newImage
                    self.menuCollectionView.reloadData()
                }
            }
            self.menu.products.append(soup)
            self.categoryCollectionView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setupCategoryCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        categoryCollectionView = UICollectionView(
            frame: CGRect(x: 0,
                          y: navigationBarHeight + statusBarHeight,
                          width: view.frame.width,
                          height: 55),
            collectionViewLayout: layout)
        
        categoryCollectionView.backgroundColor = .black
        
        categoryCollectionView.register(CategoryCell.self,
                                        forCellWithReuseIdentifier: CategoryCell.identifier)
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        view.addSubview(categoryCollectionView)
    }
    
    private func setupMenuCollectionView() {
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        menuCollectionView = UICollectionView(
            frame: CGRect(x: 0,
                          y: navigationBarHeight + statusBarHeight + categoryCollectionView.frame.height,
                          width: view.frame.width,
                          height: view.frame.height - navigationBarHeight - statusBarHeight - categoryCollectionView.frame.height - tabBarHeight),
            collectionViewLayout: layout)
        
        menuCollectionView.backgroundColor = .orange
        
        menuCollectionView.register(MenuCell.self,
                                        forCellWithReuseIdentifier: MenuCell.identifier)
        
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        
        view.addSubview(menuCollectionView)
    }
    
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == categoryCollectionView {
            return menu.products.count
        } else {
            guard menu.products.count != 0 else { return 0 }
            let group = menu.products[selectedGroupIndex]
            return group.products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
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

}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    
    // задаем размеры нашей ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoryCollectionView {
            let categoryName = menu.products[indexPath.row].name
           
            let width = categoryName.widthOfString(
                usingFont: UIFont(name: "HelveticaNeue-Medium", size: 23) ??  UIFont.systemFont(ofSize: 23))
            
            return CGSize(width: width + 20,
                          height: collectionView.frame.height)
        } else {
            return CGSize(width: UIScreen.main.bounds.width/2 - 10,
//                          height: view.safeAreaLayoutGuide.layoutFrame.height/2 - 50)
                          height: (UIScreen.main.bounds.width/2 - 10) * 7 / 4)
        }
    }
    
    // уберем отступ между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // делаем отступы между ячейками, не нарушая центровки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
