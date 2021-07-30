//
//  CategoryCell.swift
//  percy
//
//  Created by Антон Усов on 29.07.2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    private let categoryFoodLabel: UILabel = {
        let categoryFoodLabel = UILabel()
        
        categoryFoodLabel.textColor = .white
        categoryFoodLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 23)
        categoryFoodLabel.textAlignment = .center
        
        categoryFoodLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return categoryFoodLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(categoryFoodLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(category: String) {
        categoryFoodLabel.text = category
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(categoryFoodLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(categoryFoodLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 10))
        constraints.append(categoryFoodLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(categoryFoodLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }

}
