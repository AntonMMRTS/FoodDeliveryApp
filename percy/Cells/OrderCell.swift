//
//  OrderCell.swift
//  percy
//
//  Created by Антон Усов on 13.08.2021.
//

import UIKit

class OrderCell: UITableViewCell {
    
    static let identifier = "OrderCell"
    
    var product: Product! {
        didSet {
            self.nameLabel.text = product.name
            self.priceLabel.text = "\(product.price) ₽"
            self.quantityLabel.text = "\(product.quantity) шт"
        }
    }
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var quantityLabel: UILabel = {
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
        label.font = UIFont(name: "HelveticaNeue", size: 17)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        autolayoutSetup()
    }
    
    private func autolayoutSetup() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 46),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            quantityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -10),
            quantityLabel.widthAnchor.constraint(equalToConstant: 46),
            quantityLabel.heightAnchor.constraint(equalToConstant: 20),
            quantityLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor,
                                                   constant: 10)
        ])
    }
    
    private func setup() {
        contentView.backgroundColor = .black
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityLabel)
    }
    
}
