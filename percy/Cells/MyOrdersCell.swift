//
//  MyOrdersCell.swift
//  percy
//
//  Created by Антон Усов on 18.08.2021.
//

import UIKit

class MyOrdersCell: UITableViewCell {
    
    static let identifier = "MyOrdersCell"
    
    private let imageLabel: UIImageView = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        autolayoutSetup()
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
    
    private func autolayoutSetup() {
        NSLayoutConstraint.activate([
            imageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageLabel.widthAnchor.constraint(equalToConstant: 26),
            imageLabel.heightAnchor.constraint(equalToConstant: 26),
            imageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            dateLabel.leadingAnchor.constraint(equalTo: imageLabel.trailingAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 25),
            dateLabel.widthAnchor.constraint(equalToConstant: 160),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 46),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            productsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            productsLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            productsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            productsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            productsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    private func setup() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(productsLabel)
        contentView.addSubview(imageLabel)
        
        imageLabel.layer.cornerRadius = 13
        imageLabel.clipsToBounds = true
    }
    
}
