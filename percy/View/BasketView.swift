//
//  BasketView.swift
//  percy
//
//  Created by Антон Усов on 11.08.2021.
//

import UIKit
import FirebaseAuth

class BasketView: UIView {
    
    var products: [Product]!
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    
    var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .selected)
        button.setTitle("К оформлению", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: totalLabel.topAnchor, constant: -5).isActive = true
//        tableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
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
        
//        orderButton.addTarget(self, action: #selector(authtorization), for: .touchUpInside)
    }
    
//    @objc func authtorization() {
//        if Auth.auth().currentUser?.uid == nil {
//            let vc = AuthNavViewController()
//
//
//
//        }
//    }

}
