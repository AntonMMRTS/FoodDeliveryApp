//
//  MyOrdersCell.swift
//  percy
//
//  Created by Антон Усов on 18.08.2021.
//

import UIKit

class MyOrdersCell: UICollectionViewCell {
    
    static let identifier = "MyOrdersCell"
    
//    var order: MyOrder! {
//        didSet {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MMM d, yyyy"
//
//            var totalPrice = 0
//            for i in order.products {
//                var totalPrice = 0
//                totalPrice += i.price * i.quantity
//            }
//
//            var allProducts = "A"
//            for i in order.products {
//                allProducts += i.name + " "
//            }
//
//            dateLabel.text = formatter.string(from: order.date)
//            priceLabel.text = "\(totalPrice) ₽"
//            productsLabel.text = allProducts
//        }
//    }
    
    func configure(order: MyOrder) {
        let formatter = DateFormatter()
                   formatter.dateFormat = "MMM d, yyyy"
       
                   var totalPrice = 0
                   for i in order.products {
                       totalPrice += i.price * i.quantity
                   }
       
                   var allProducts = "A"
                   for i in order.products {
                       allProducts += i.name + " "
                   }
       
                   dateLabel.text = formatter.string(from: order.date)
                   priceLabel.text = "\(totalPrice) ₽"
                   productsLabel.text = allProducts
    }
    
    private var dateLabel: UILabel = {
        let label = UILabel()
      
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 22)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var productsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 27)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    override init(style: CollectionViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        contentView.backgroundColor = .black
//
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(priceLabel)
//        contentView.addSubview(quantityLabel)
//
//        setup()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .black
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(productsLabel)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: 10).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                           constant: -10).isActive = true
        priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 46).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
      
        productsLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                           constant: -10).isActive = true
        productsLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15).isActive = true
        productsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        productsLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: 10).isActive = true
    }
    
}
