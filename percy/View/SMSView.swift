//
//  SMSView.swift
//  percy
//
//  Created by Антон Усов on 12.08.2021.
//

import UIKit

class SMSView: UIView {
    
    let codeTetxView: UITextView = {
        let textView = UITextView()
        textView.keyboardType = .phonePad
        textView.textAlignment = .center
        textView.backgroundColor = .black
        textView.font = UIFont(name: "Helvetica Neue", size: 30)
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var checkCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .selected)
        button.setTitle("Проверить код", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var justLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "SMS-сообщение с кодом отправлено на номер +79012408720"
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
    
    func setupView() {
        
        addSubview(justLabel)
        addSubview(checkCodeButton)
        addSubview(codeTetxView)
        
        justLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        justLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        justLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        justLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20) .isActive = true
        
        checkCodeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkCodeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        checkCodeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkCodeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        codeTetxView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        codeTetxView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        codeTetxView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        codeTetxView.bottomAnchor.constraint(equalTo: checkCodeButton.topAnchor,
                                             constant: -50).isActive = true
    }
    
}
