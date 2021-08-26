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
        
        contentView.addSubview(addressLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(productsLabel)
        contentView.addSubview(imageLabel)

        imageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        imageLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imageLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        imageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        
        imageLabel.layer.cornerRadius = 13
        imageLabel.clipsToBounds = true
        
        addressLabel.leadingAnchor.constraint(equalTo: imageLabel.trailingAnchor,
                                           constant: 20).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        addressLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                             constant: -10).isActive = true
        priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 46).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        productsLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -10).isActive = true
        productsLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
        productsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        productsLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: 10).isActive = true
        productsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
    }

}
