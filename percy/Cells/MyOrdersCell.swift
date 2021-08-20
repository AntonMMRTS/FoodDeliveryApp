//
//  MyOrdersCell.swift
//  percy
//
//  Created by Антон Усов on 18.08.2021.
//

import UIKit

class MyOrdersCell: UICollectionViewCell {
    
    static let identifier = "MyOrdersCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "perec")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 22)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 27)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(order: MyOrder) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        var totalPrice = 0
        for i in order.products {
            totalPrice += i.price * i.quantity
        }
        
        var allProducts = ""
        
        for (index,value) in order.products.enumerated() {
            switch index {
            case 0:                         allProducts += "\(value.name), "
            case order.products.count - 1:  allProducts += "\(value.name.lowercased())."
            default:                        allProducts += "\(value.name.lowercased()), "
            }
        }
        
        dateLabel.text = formatter.string(from: order.date)
        priceLabel.text = "\(totalPrice) ₽"
        productsLabel.text = allProducts
    }
    
    private func setup() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(productsLabel)
        contentView.addSubview(imageView)
        
        contentView.layer.cornerRadius = 15
//        contentView.layer.shadowColor = UIColor.white.cgColor
//        contentView.layer.shadowOffset = CGSize(width: 5, height: 3)
//        contentView.layer.shadowRadius = 3
//        contentView.layer.shadowOpacity = 0.5

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        imageView.layer.cornerRadius = 13
        imageView.clipsToBounds = true
        
        dateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,
                                           constant: 20).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                             constant: -10).isActive = true
        priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 46).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        productsLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -10).isActive = true
        productsLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
//        productsLabel.topAnchor.constraint(lessThanOrEqualTo: dateLabel.bottomAnchor, constant: 25).isActive = true
        productsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        productsLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 56).isActive = true
        productsLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: 10).isActive = true
    }
    
}
