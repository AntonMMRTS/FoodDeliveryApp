import UIKit

class MenuViewController: UIViewController {
    
//    var categorys = ["Pizza", "Pasta", "Hot", "Drinks", "Deserts", "Salad", "Lasagna"]
    
    var menu: Menu!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = Menu()
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        setupCategoryCollectionView()
    }
    
    private func setupCategoryCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let categoryCollectionView = UICollectionView(
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
    
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier,
                                                      for: indexPath) as! CategoryCell
        
        let categoryName = menu.products[indexPath.row].name
        cell.setupCell(category: categoryName)
        
        return cell
    }

}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    
    // задаем размеры нашей ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let categoryName = menu.products[indexPath.row].name
        
        let width = categoryName.widthOfString(
            usingFont: UIFont(name: "HelveticaNeue-Medium", size: 23) ??  UIFont.systemFont(ofSize: 23))
        
        return CGSize(width: width + 20,
                      height: collectionView.frame.height)
    }
    
}
