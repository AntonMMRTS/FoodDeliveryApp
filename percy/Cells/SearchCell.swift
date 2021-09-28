//
//  SearchCell.swift
//  percy
//
//  Created by Антон Усов on 25.09.2021.
//

import UIKit

class SearchCell: UITableViewCell {
    
    static let identifier = "SearchCell"

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
