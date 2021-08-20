import UIKit

class ProductDetailViewController: UIViewController {
    
    var product: Product!
    var customView = ProductDetailView()
    private let databaseManager: DatabaseManagerProtocol = RealmManager()
    
    override func loadView() {
       self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        currentProductSetup()
        
        addToBasket()
    }
    
    private func addToBasket() {
        customView.orderButton.addTarget(self, action: #selector(buttonFunction), for: .touchUpInside)
    }
    
    @objc private func buttonFunction() {
        databaseManager.addNewProduct(product: product)
        self.tabBarController?.tabBar.items?.last?.badgeValue = "\(databaseManager.obtainProducts().count)"
    }
    
    private func configure() {
        view.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func currentProductSetup() {
        customView.nameLabel.text = product.name
        customView.productImage.image = UIImage(data: product.image) 
        customView.weightLabel.text = product.weight
        customView.priceLabel.text = "\(product.price) ₽"
        customView.energyValueLabel.text = product.halories
        customView.definitionLabel.text = product.definition
        customView.bguValueLabel.text = product.energyValue
    }
}


