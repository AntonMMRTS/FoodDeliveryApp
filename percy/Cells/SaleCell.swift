//
//  SaleCell.swift
//  percy
//
//  Created by Антон Усов on 09.08.2021.
//

import UIKit

class SaleCell: UITableViewCell {
    
    static let identifier = "SaleCell"
    
    public var sale: Sale! {
        didSet {
            self.saleImage.image = sale.image
            self.nameLabel.text = sale.shortDefinition
        }
    }
    
    private var saleImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(saleImage)
        contentView.backgroundColor = .black
        
        saleImage.image = UIImage(named: "default")
        saleImage.contentMode = .scaleAspectFit
        saleImage.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        
        saleImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        saleImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        saleImage.heightAnchor.constraint(equalTo: saleImage.widthAnchor, multiplier: 0.52).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        nameLabel.topAnchor.constraint(equalTo: saleImage.bottomAnchor).isActive = true
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 33).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
    }
    
}
