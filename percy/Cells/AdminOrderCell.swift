//
//  AdminOrderCell.swift
//  percy
//
//  Created by Антон Усов on 25.08.2021.
//

import UIKit

class AdminOrderCell: UITableViewCell {
    
    static let identifier = "AdminOrderCell"
    
    private let imageLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "perec")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let addressLabel: UILabel = {
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(order: AdminOrder) {
        
        var allProducts = ""
        
        for (index,value) in order.order.enumerated() {
            switch index {
            case 0:                         allProducts += "\(value.name), "
            case order.order.count - 1:     allProducts += "\(value.name.lowercased())."
            default:                        allProducts += "\(value.name.lowercased()), "
            }
        }
        
        addressLabel.text = order.address
        priceLabel.text = "\(order.totalPrice) ₽"
        productsLabel.text = allProducts
    }
    
    private func setup() {
        
        contentView.backgroundColor = .black
        
        imageLabel.layer.cornerRadius = 13
        imageLabel.clipsToBounds = true
        
        contentView.addSubview(addressLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(productsLabel)
        contentView.addSubview(imageLabel)
        
        NSLayoutConstraint.activate([
            imageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageLabel.widthAnchor.constraint(equalToConstant: 26),
            imageLabel.heightAnchor.constraint(equalToConstant: 26),
            imageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            addressLabel.leadingAnchor.constraint(equalTo: imageLabel.trailingAnchor, constant: 20),
            addressLabel.heightAnchor.constraint(equalToConstant: 25),
            addressLabel.widthAnchor.constraint(equalToConstant: 160),
            addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 46),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            
            productsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            productsLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            productsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            productsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
}
