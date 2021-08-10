import UIKit

class MenuCell: UICollectionViewCell {
    
    static let identifier = "MenuCell"
    
    var product: Product! {
        didSet {
            self.productImage.image = product.image
            self.nameLabel.text = product.name
            self.definitionLabel.text = product.definition
            self.priceLabel.text = "\(product.price) ₽"
        }
    }
    
    var productImage: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: "default")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Anton"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textAlignment = .left

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var definitionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .left

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var priceLabel: UILabel = {
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

    private var orderButton: UIButton = {
        let button = UIButton()
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
        
        contentView.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        contentView.layer.cornerRadius = 15
        
        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(definitionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(orderButton)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(productImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(productImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(productImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(productImage.heightAnchor.constraint(equalToConstant: contentView.frame.width))

        constraints.append(nameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 5))
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5))
        constraints.append(nameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5))
        constraints.append(nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20))
        
        constraints.append(definitionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10))
        constraints.append(definitionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5))
        constraints.append(definitionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5))
        constraints.append(definitionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16))
        
        constraints.append(priceLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5))
        constraints.append(priceLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        constraints.append(priceLabel.widthAnchor.constraint(equalToConstant: 60))
        constraints.append(priceLabel.heightAnchor.constraint(equalToConstant: 20))
        
        constraints.append(orderButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        constraints.append(orderButton.widthAnchor.constraint(equalToConstant: 100))
        constraints.append(orderButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -7))
        constraints.append(orderButton.heightAnchor.constraint(equalToConstant: 32))
        constraints.append(orderButton.topAnchor.constraint(greaterThanOrEqualTo: definitionLabel.bottomAnchor, constant: 5))
        
        NSLayoutConstraint.activate(constraints)
    }

}
