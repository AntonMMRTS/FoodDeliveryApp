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

    let addressTetxField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Helvetica Neue", size: 17)
//        textField.textColor = .white
        textField.placeholder = "Введите адресс"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let commentTetxField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Комментарии"
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Helvetica Neue", size: 17)
//        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var orderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .selected)
        button.setTitle("К оформлению", for: .normal)
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
    
    func setupView() {
       
        addSubview(tableView)
        addSubview(totalLabel)
        addSubview(sumLabel)
        addSubview(orderButton)
        addSubview(addressTetxField)
        addSubview(commentTetxField)
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: addressTetxField.topAnchor, constant: -15).isActive = true

        addressTetxField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        addressTetxField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        addressTetxField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addressTetxField.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        commentTetxField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        commentTetxField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        commentTetxField.topAnchor.constraint(equalTo: addressTetxField.bottomAnchor, constant: 55).isActive = true
        commentTetxField.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        orderButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        orderButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        orderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        totalLabel.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -15).isActive = true
        totalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        totalLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        totalLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        sumLabel.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -15).isActive = true
        sumLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        sumLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sumLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    


}
