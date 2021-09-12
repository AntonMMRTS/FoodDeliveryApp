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
            if let url = URL(string: product.productURL) {
                self.productImage.sd_imageTransition = .fade
                self.productImage.sd_imageTransition?.duration = 0.5
                self.productImage.sd_setImage(with: url, placeholderImage: UIImage(named: "default"), options: []) { (uiImage, error, cashe, url) in
                    
                    guard uiImage != nil else { return }
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

    
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private let priceLabel: UILabel = {
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
        
        orderButton.addTarget(self, action: #selector(buttonFunction), for: .touchUpInside)
        
        contentView.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        contentView.layer.cornerRadius = 15
        
        productImage.image = UIImage(named: "default")
        
        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(definitionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(orderButton)
        
        NSLayoutConstraint.activate([
            productImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            productImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                                              constant: 10),
            productImage.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            nameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -5),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            definitionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            definitionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                                                     constant: 5),
            definitionLabel.trailingAnchor.constraint(equalTo:contentView.safeAreaLayoutGuide.trailingAnchor,
                                                      constant: -5),
            definitionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),
            
            priceLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                                                constant: 5),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                                               constant: -10),
            priceLabel.widthAnchor.constraint(equalToConstant: 60),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            orderButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -10),
            orderButton.widthAnchor.constraint(equalToConstant: 100),
            orderButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                                                constant: -7),
            orderButton.heightAnchor.constraint(equalToConstant: 32),
            orderButton.topAnchor.constraint(greaterThanOrEqualTo: definitionLabel.bottomAnchor,
                                             constant: 5),
        ])
    }
    
    @objc private func buttonFunction() {
        databaseManager.addNewProduct(product: product)
        closure?()
    }
    
}
