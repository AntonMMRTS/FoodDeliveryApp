import UIKit

class ProductDetailView: UIView {
    
    var scrollView: UIScrollView!
    
    var nameLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
       
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var productImage: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
    
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
//        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var orderButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .selected)
        button.setTitle("Заказать", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
       
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var weightLabel: UILabel = {
        let label = UILabel()
    
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var definitionLabel: UILabel = {
        let label = UILabel()
    
        label.numberOfLines = 0
        label.textColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var energyValueLabel: UILabel = {
        let label = UILabel()
    
        label.numberOfLines = 0
        label.textColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        label.text = "sdfsdfsd"

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var bguValueLabel: UILabel = {
        let label = UILabel()
    
        label.numberOfLines = 0
        label.textColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
       
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var compositionLabel: UILabel = {
        let label = UILabel()
    
        label.text = "Состав:"
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 19)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var energyLabel: UILabel = {
        let label = UILabel()
    
        label.text = "Энергетическая ценность за порцию:"
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 19)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var bguLabel: UILabel = {
        let label = UILabel()
    
        label.text = "Основные питательные вещества:"
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 19)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
      
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    
        addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
       
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
        
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 33).isActive = true
        
        productImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        productImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        productImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        productImage.heightAnchor.constraint(equalTo: productImage.widthAnchor ).isActive = true

        priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        priceLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 33).isActive = true

        orderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        orderButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        orderButton.topAnchor.constraint(equalTo: productImage.bottomAnchor).isActive = true
      
        weightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        weightLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        weightLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        weightLabel.heightAnchor.constraint(equalToConstant: 33).isActive = true

        compositionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        compositionLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 10).isActive = true
        compositionLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true

        definitionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        definitionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        definitionLabel.topAnchor.constraint(equalTo: compositionLabel.bottomAnchor, constant: 5).isActive = true
        definitionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21).isActive = true

        energyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        energyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        energyLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 15).isActive = true
        energyLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true

        energyValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        energyValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        energyValueLabel.topAnchor.constraint(equalTo: energyLabel.bottomAnchor, constant: 5).isActive = true
        energyValueLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21).isActive = true

        bguLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        bguLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        bguLabel.topAnchor.constraint(equalTo: energyValueLabel.bottomAnchor, constant: 15).isActive = true
        bguLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true

        bguValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        bguValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        bguValueLabel.topAnchor.constraint(equalTo: bguLabel.bottomAnchor, constant: 5).isActive = true
        bguValueLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21).isActive = true
        bguValueLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
    }
}
