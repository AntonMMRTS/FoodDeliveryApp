import UIKit
import SDWebImage

class MenuCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        productImage.sd_cancelCurrentImageLoad()
        productImage.image  = UIImage(named: "default")
    }
    
    static let identifier = "MenuCell"
    
    var closure: (() -> Void)?
    var closure2: (() -> Void)?
    
    var product: Product! {
        didSet {
//            self.productImage.image = UIImage(data: product.image)
            
            if let url = URL(string: product.productURL) {
                self.productImage.sd_imageTransition = .fade
                self.productImage.sd_imageTransition?.duration = 0.5
                self.productImage.sd_setImage(with: url, placeholderImage: UIImage(named: "default"), options: []) { (uiImage, error, cashe, url) in
                    
                    self.product.image = uiImage!.jpegData(compressionQuality: 1)!
                }
                
            } else {
                print("url didnt work \(product.productURL)")
            }
            
            self.nameLabel.text = product.name
            self.definitionLabel.text = product.definition
            self.priceLabel.text = "\(product.price) ₽"
        }
    }
    
    private let databaseManager: DatabaseManagerProtocol = RealmManager()
    
    let productImage: UIImageView = {
        let image = UIImageView()
        image.image  = UIImage(named: "default")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
     let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Anton"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

     let definitionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

     let priceLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.backgroundColor = UIColor(red: 64/255, green: 63/255, blue: 70/255, alpha: 1)
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .selected)
        button.setTitle("Заказать", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        contentView.layer.cornerRadius = 15
        
        productImage.image = UIImage(named: "default")
        
        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(definitionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(orderButton)
        
        productImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        productImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        productImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10)
            .isActive = true
        productImage.heightAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true

        nameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                                           constant: 5).isActive = true
       nameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                                           constant: -5).isActive = true
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        definitionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
            .isActive = true
        definitionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 5).isActive = true
       definitionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -5).isActive = true
        definitionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
        
        priceLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                                            constant: 5).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                                           constant: -10).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        orderButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                                              constant: -10).isActive = true
        orderButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        orderButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                                            constant: -7).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        orderButton.topAnchor.constraint(greaterThanOrEqualTo: definitionLabel.bottomAnchor,
                                         constant: 5).isActive = true
        
        orderButton.addTarget(self, action: #selector(buttonFunction), for: .touchUpInside)
    }
    
    @objc private func buttonFunction() {
        databaseManager.addNewProduct(product: product)
        closure?()
    }

}
