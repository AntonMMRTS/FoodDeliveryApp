//
//  SaleCell.swift
//  percy
//
//  Created by Антон Усов on 09.08.2021.
//

import UIKit
import SDWebImage

class SaleCell: UITableViewCell {
    
    static let identifier = "SaleCell"
    
    var sale: Sale! {
        didSet {
            if let url = URL(string: sale.saleURL) {
                self.saleImage.sd_imageTransition = .fade
                self.saleImage.sd_imageTransition?.duration = 0.5
                self.saleImage.sd_setImage(with: url, placeholderImage: UIImage(named: "default"),
                                           options: []) { (uiImage, error, cashe, url) in
                    guard uiImage != nil else { return }
                    self.sale.image = uiImage!
                }
                
            } else {
                print("url didnt work \(sale.saleURL)")
            }
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
        config()
        autolayoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        saleImage.sd_cancelCurrentImageLoad()
        saleImage.image = UIImage(named: "default")
    }
    
    private func autolayoutSetup() {
        NSLayoutConstraint.activate([
            saleImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            saleImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            saleImage.heightAnchor.constraint(equalTo: saleImage.widthAnchor, multiplier: 0.52),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: saleImage.bottomAnchor),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 33),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func config() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(saleImage)
        contentView.backgroundColor = .black
        
        saleImage.image = UIImage(named: "default")
        saleImage.contentMode = .scaleAspectFit
        saleImage.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
    }
    
}
