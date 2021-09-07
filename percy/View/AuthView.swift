//
//  AuthView.swift
//  percy
//
//  Created by Антон Усов on 12.08.2021.
//

import UIKit
import FlagPhoneNumber

class AuthView: UIView {
    
    let phoneTetxField: FPNTextField = {
        let textField = FPNTextField()
        textField.displayMode = .list
        textField.backgroundColor = .black
        textField.font = UIFont(name: "Helvetica Neue", size: 26)
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var getCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .selected)
        button.setTitle("Получить код", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var justLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Введите номер мобильного телефона"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
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
        
        addSubview(justLabel)
        addSubview(getCodeButton)
        addSubview(phoneTetxField)
        
        NSLayoutConstraint.activate([
            justLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            justLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            justLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            justLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            getCodeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            getCodeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            getCodeButton.heightAnchor.constraint(equalToConstant: 50),
            getCodeButton.widthAnchor.constraint(equalToConstant: 200),
            
            phoneTetxField.heightAnchor.constraint(equalToConstant: 52),
            phoneTetxField.widthAnchor.constraint(equalToConstant: 250),
            phoneTetxField.centerXAnchor.constraint(equalTo:centerXAnchor),
            phoneTetxField.bottomAnchor.constraint(equalTo: getCodeButton.topAnchor, constant: -50)
        ])
    }
    
}
