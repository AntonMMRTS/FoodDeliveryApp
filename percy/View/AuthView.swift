//
//  AuthView.swift
//  percy
//
//  Created by Антон Усов on 12.08.2021.
//

import UIKit

class AuthView: UIView {
    
    private var justLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Введите номер мобильного телефона"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
//        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneTetxField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.font = UIFont(name: "Helvetica Neue", size: 26)
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var getCodeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .selected)
        button.setTitle("Получить код", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        addSubview(justLabel)
        addSubview(getCodeButton)
        addSubview(phoneTetxField)
        
        justLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        justLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        justLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        justLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20) .isActive = true
        
        getCodeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        getCodeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        getCodeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        getCodeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        phoneTetxField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        phoneTetxField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        phoneTetxField.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        phoneTetxField.bottomAnchor.constraint(equalTo: getCodeButton.topAnchor,
                                               constant: -50).isActive = true

    }

}
