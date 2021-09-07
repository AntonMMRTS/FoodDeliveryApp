import UIKit

class ProductDetailView: UIView {
    
    var scrollView: UIScrollView!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .selected)
        button.setTitle("Заказать", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let energyValueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        label.text = "sdfsdfsd"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bguValueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let compositionLabel: UILabel = {
        let label = UILabel()
        label.text = "Состав:"
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let energyLabel: UILabel = {
        let label = UILabel()
        label.text = "Энергетическая ценность за порцию:"
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bguLabel: UILabel = {
        let label = UILabel()
        label.text = "Основные питательные вещества:"
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(productImage)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(orderButton)
        scrollView.addSubview(weightLabel)
        scrollView.addSubview(compositionLabel)
        scrollView.addSubview(definitionLabel)
        scrollView.addSubview(energyLabel)
        scrollView.addSubview(energyValueLabel)
        scrollView.addSubview(bguLabel)
        scrollView.addSubview(bguValueLabel)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 33),
            
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            productImage.heightAnchor.constraint(equalTo: productImage.widthAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            priceLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 80),
            priceLabel.heightAnchor.constraint(equalToConstant: 33),
            
            orderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            orderButton.widthAnchor.constraint(equalToConstant: 160),
            orderButton.heightAnchor.constraint(equalToConstant: 45),
            orderButton.topAnchor.constraint(equalTo: productImage.bottomAnchor),
            
            weightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weightLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            weightLabel.widthAnchor.constraint(equalToConstant: 80),
            weightLabel.heightAnchor.constraint(equalToConstant: 33),
            
            compositionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            compositionLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 10),
            compositionLabel.heightAnchor.constraint(equalToConstant: 23),
            
            definitionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            definitionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            definitionLabel.topAnchor.constraint(equalTo: compositionLabel.bottomAnchor, constant: 5),
            definitionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21),
            
            energyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            energyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            energyLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 15),
            energyLabel.heightAnchor.constraint(equalToConstant: 23),
            
            energyValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            energyValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            energyValueLabel.topAnchor.constraint(equalTo: energyLabel.bottomAnchor, constant: 5),
            energyValueLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21),
            
            bguLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bguLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bguLabel.topAnchor.constraint(equalTo: energyValueLabel.bottomAnchor, constant: 15),
            bguLabel.heightAnchor.constraint(equalToConstant: 23),
            
            bguValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bguValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bguValueLabel.topAnchor.constraint(equalTo: bguLabel.bottomAnchor, constant: 5),
            bguValueLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21),
            bguValueLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50)
        ])
    }

}
