//
//  OrderView.swift
//  percy
//
//  Created by Антон Усов on 13.08.2021.
//

import UIKit
import FirebaseAuth

class OrderView: UIView {
    
    var whenButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.contentHorizontalAlignment = .right
        button.setTitle("Как можно быстрее", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var payButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.contentHorizontalAlignment = .right
        button.setTitle("Картой онлайн", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let commentTetxField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        textField.attributedPlaceholder = NSAttributedString(string: "Примечание к заказу",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Укажите адрес"
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.backgroundColor = UIColor(red: 37/255, green: 36/255, blue: 42/255, alpha: 1)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private var delivery = true
    
    private var deliveryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Доставка", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 31)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var notDeliveryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1), for: .normal)
        button.setTitle("Самовывоз", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 31)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let whereLabel: UILabel = {
        let label = UILabel()
        label.text = "Куда"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let whenLabel: UILabel = {
        let label = UILabel()
        label.text = "Когда"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let payLabel: UILabel = {
        let label = UILabel()
        label.text = "Оплата"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let personsAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество персон"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        autolayoutSetup()
    }
    
    @objc private func chooseDelivery() {
        if delivery {
            deliveryButton.setTitleColor(UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1),
                                         for: .normal)
            notDeliveryButton.setTitleColor(.white, for: .normal)
            
            UIView.animate(withDuration: 0.3) {
                self.deliveryButton.transform = self.deliveryButton.transform.scaledBy(x: 0.5, y: 0.5)
                self.notDeliveryButton.transform = self.notDeliveryButton.transform.scaledBy(x: 2, y: 2)
            }
            
            delivery = false
        }
    }
    
    @objc private func chooseNotDelivery() {
        if !delivery {
            notDeliveryButton.setTitleColor(UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1),
                                            for: .normal)
            deliveryButton.setTitleColor(.white, for: .normal)
            
            UIView.animate(withDuration: 0.3) {
                self.notDeliveryButton.transform = self.notDeliveryButton.transform.scaledBy(x: 0.5, y: 0.5)
                self.deliveryButton.transform = self.deliveryButton.transform.scaledBy(x: 2, y: 2)
            }
            
            delivery = true
        }
    }
    
    private func setupView() {
        notDeliveryButton.transform = notDeliveryButton.transform.scaledBy(x: 0.5, y: 0.5)
        
        notDeliveryButton.addTarget(self, action: #selector(chooseDelivery), for: .touchUpInside)
        deliveryButton.addTarget(self, action: #selector(chooseNotDelivery), for: .touchUpInside)
        
        addSubview(deliveryButton)
        addSubview(notDeliveryButton)
        addSubview(whereLabel)
        addSubview(addressLabel)
        addSubview(whenLabel)
        addSubview(whenButton)
        addSubview(payLabel)
        addSubview(payButton)
        addSubview(personsAmountLabel)
        addSubview(totalLabel)
        addSubview(sumLabel)
        addSubview(orderButton)
        addSubview(commentTetxField)
        
        commentTetxField.setBottomBorder()
    }
    
    private func autolayoutSetup() {
        NSLayoutConstraint.activate([
            deliveryButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            deliveryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            deliveryButton.widthAnchor.constraint(equalToConstant: 158),
            deliveryButton.heightAnchor.constraint(equalToConstant: 57),
            
            notDeliveryButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            notDeliveryButton.leadingAnchor.constraint(equalTo: deliveryButton.trailingAnchor, constant: 8),
            notDeliveryButton.widthAnchor.constraint(equalToConstant: 185),
            notDeliveryButton.heightAnchor.constraint(equalToConstant: 57),
            
            whereLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            whereLabel.widthAnchor.constraint(equalToConstant: 70),
            whereLabel.heightAnchor.constraint(equalToConstant: 17),
            whereLabel.topAnchor.constraint(equalTo: deliveryButton.bottomAnchor, constant: 20),
            
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            addressLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            addressLabel.topAnchor.constraint(equalTo: whereLabel.bottomAnchor, constant: 12),
            
            whenLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            whenLabel.widthAnchor.constraint(equalToConstant: 70),
            whenLabel.heightAnchor.constraint(equalToConstant: 17),
            whenLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 40),
            
            whenButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            whenButton.widthAnchor.constraint(equalToConstant: 180),
            whenButton.heightAnchor.constraint(equalToConstant: 17),
            whenButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 40),
            
            payLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            payLabel.widthAnchor.constraint(equalToConstant: 70),
            payLabel.heightAnchor.constraint(equalToConstant: 17),
            payLabel.topAnchor.constraint(equalTo: whenButton.bottomAnchor, constant: 40),
            
            payButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            payButton.widthAnchor.constraint(equalToConstant: 180),
            payButton.heightAnchor.constraint(equalToConstant: 17),
            payButton.topAnchor.constraint(equalTo: whenButton.bottomAnchor, constant: 40),
            
            personsAmountLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                        constant: 20),
            personsAmountLabel.widthAnchor.constraint(equalToConstant: 180),
            personsAmountLabel.heightAnchor.constraint(equalToConstant: 17),
            personsAmountLabel.topAnchor.constraint(equalTo: payLabel.bottomAnchor, constant: 40),
            
            commentTetxField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            commentTetxField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            commentTetxField.topAnchor.constraint(equalTo: personsAmountLabel.topAnchor, constant: 45),
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
