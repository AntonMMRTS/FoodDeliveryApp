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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        autolayoutSetup()
    }
    
    private func setupView() {
        addSubview(justLabel)
        addSubview(checkCodeButton)
        addSubview(codeTetxView)
    }
    
    private func autolayoutSetup() {
        NSLayoutConstraint.activate([
            justLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            justLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            justLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            justLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            checkCodeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkCodeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkCodeButton.heightAnchor.constraint(equalToConstant: 50),
            checkCodeButton.widthAnchor.constraint(equalToConstant: 200),
            
            codeTetxView.heightAnchor.constraint(equalToConstant: 52),
            codeTetxView.widthAnchor.constraint(equalToConstant: 250),
            codeTetxView.centerXAnchor.constraint(equalTo:centerXAnchor),
            codeTetxView.bottomAnchor.constraint(equalTo: checkCodeButton.topAnchor, constant: -50)
        ])
    }
    
}
