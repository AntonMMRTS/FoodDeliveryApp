//
//  SearchView.swift
//  percy
//
//  Created by Антон Усов on 28.09.2021.
//

import UIKit

class SearchView: UIView {
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Введите адрес",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.becomeFirstResponder()
        return textField
    }()
    
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubview(tableView)
        addSubview(addressTextField)
        addSubview(lineView)
        
        NSLayoutConstraint.activate([
            addressTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            addressTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            addressTextField.heightAnchor.constraint(equalToConstant: 45),
            
            lineView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
          
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor)
        ])
    }

}
