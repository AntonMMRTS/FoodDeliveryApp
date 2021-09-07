//
//  BasketCell.swift
//  percy
//
//  Created by Антон Усов on 11.08.2021.
//

import UIKit

class BasketCell: UITableViewCell {

    static let identifier = "BasketCell"
    
    var closure: (() -> Void)?
    
    var product: Product! {
        didSet {
            self.productImage.image = UIImage(data: product.image)
            self.nameLabel.text = product.name
            self.priceLabel.text = "\(product.price) ₽"
            self.guantity = product.quantity
        }
    }
    
    var guantity = 1 {
        didSet {
            sumLabel.text = "\(guantity)"
            priceLabel.text = "\(guantity * product.price) ₽"
        }
    }
    
    private let databaseManager: DatabaseManagerProtocol = RealmManager()
    
    private var productImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Anton"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var sumLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .selected)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .selected)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .black
        
        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(sumLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(plusButton)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func increaseQuantity() {
        databaseManager.updateProductStart()
        guantity += 1
        product.quantity = guantity
        databaseManager.updateProductEnd()
        closure?()
    }
    
    @objc private func decreaseQuantity() {
        if guantity > 1 {
            databaseManager.updateProductStart()
            guantity -= 1
            product.quantity = guantity
            databaseManager.updateProductEnd()
            closure?()
        }
    }

    private func setup() {
        
        plusButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productImage.widthAnchor.constraint(equalToConstant: 90),
            productImage.heightAnchor.constraint(equalToConstant: 90),
            productImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            productImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            priceLabel.widthAnchor.constraint(equalToConstant: 60),
            priceLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
            
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            sumLabel.widthAnchor.constraint(equalToConstant: 40),
            sumLabel.heightAnchor.constraint(equalToConstant: 30),
            sumLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sumLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -5),
            
            minusButton.widthAnchor.constraint(equalToConstant: 30),
            minusButton.heightAnchor.constraint(equalToConstant: 30),
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: sumLabel.leadingAnchor, constant: -5)
        ])
    }

}
