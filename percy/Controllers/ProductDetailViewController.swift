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
        
        navigationController?.navigationBar.prefersLargeTitles = true

        title = product.name
        
        navigationController?.navigationBar.tintColor = .white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)]
    }
    
    private func currentProductSetup() {
        customView.productImage.image = product.image
        customView.weightLabel.text = product.weight
        customView.priceLabel.text = "\(product.price) ₽"
        customView.energyValueLabel.text = product.halories
        customView.definitionLabel.text = product.definition
        customView.bguValueLabel.text = product.energyValue
    }
}


