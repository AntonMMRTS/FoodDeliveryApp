//
//  SuggestCellTableViewCell.swift
//  percy
//
//  Created by Антон Усов on 24.09.2021.
//

import UIKit

class SuggestCell: UITableViewCell {
    
    static let identifier = "suggestCell"

    var suggestLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(suggestLabel)
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
            suggestLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            suggestLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            suggestLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            suggestLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}
