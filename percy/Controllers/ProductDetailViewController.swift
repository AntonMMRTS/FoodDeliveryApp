import UIKit

class ProductDetailViewController: UIViewController {
    
    var product: Product!
    var customView = ProductDetailView()
    
    override func loadView() {
       self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        
        navigationControllerSettings()
        currentProductSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.setupLayout()
    }
    
    private func navigationControllerSettings() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        
        navigationController?.navigationBar.tintColor = .white
//        title = product.name
    }
    
    private func currentProductSetup() {
        customView.nameLabel.text = product.name
        customView.productImage.image = product.image
        customView.weightLabel.text = product.weight
        customView.priceLabel.text = "\(product.price) ₽"
        customView.energyValueLabel.text = product.halories
        customView.definitionLabel.text = product.definition
        customView.bguValueLabel.text = product.energyValue
    }
}


