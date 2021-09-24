//
//  OrderView.swift
//  percy
//
//  Created by Антон Усов on 13.08.2021.
//

import UIKit
import FirebaseAuth

class OrderView: UIView {
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(OrderCell.self, forCellReuseIdentifier: OrderCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

//    let addressTetxField: UITextField = {
//        let textField = UITextField()
//        textField.backgroundColor = .white
//        textField.font = UIFont(name: "Helvetica Neue", size: 17)
//        textField.placeholder = "Введите адресс"
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
    
    var addressButton: UIButton = {
        let button = UIButton(type: .system)
//        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.backgroundColor = .white
        button.setTitleColor(.systemGray4, for: .normal)
//        button.layer.cornerRadius = 15
//        button.setTitleColor(.black, for: .selected)
        button.contentHorizontalAlignment = .left
        button.setTitle("Введите адрес", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let commentTetxField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Комментарии"
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Helvetica Neue", size: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .selected)
        button.setTitle("Заказать", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var sumLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Итого:"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(totalLabel)
        addSubview(sumLabel)
        addSubview(orderButton)
        addSubview(addressButton)
        addSubview(commentTetxField)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addressButton.topAnchor, constant: -15),
            
            addressButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            addressButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            addressButton.heightAnchor.constraint(equalToConstant: 34),
            addressButton.bottomAnchor.constraint(equalTo: commentTetxField.topAnchor, constant: -15),
            
            commentTetxField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            commentTetxField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            commentTetxField.bottomAnchor.constraint(equalTo: totalLabel.topAnchor, constant: -15),
            commentTetxField.heightAnchor.constraint(equalToConstant: 34),
            
            orderButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            orderButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            orderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            orderButton.heightAnchor.constraint(equalToConstant: 52),
            
            totalLabel.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -15),
            totalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            totalLabel.widthAnchor.constraint(equalToConstant: 150),
            totalLabel.heightAnchor.constraint(equalToConstant: 30),
            
            sumLabel.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -15),
            sumLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            sumLabel.widthAnchor.constraint(equalToConstant: 100),
            sumLabel.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
    
}
