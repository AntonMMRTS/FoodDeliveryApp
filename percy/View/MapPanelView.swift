//
//  MapPanelView.swift
//  percy
//
//  Created by Антон Усов on 30.09.2021.
//

import UIKit

class MapPanelView: UIView, UITextFieldDelegate {
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = .black
        label.textColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
 
    let porchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Подьезд",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
 
    let floorTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Этаж",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    
    let flatTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Кв./Офис",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()

    let intercomTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Домофон",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let commentsTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Примечание к адресу",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 214/255, green: 1/255, blue: 0/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .selected)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let porchLabel: UILabel = {
        let label = UILabel()
        label.text = "Подьезд"
        label.isHidden = true
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.backgroundColor = .black
        label.textColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let floorLabel: UILabel = {
        let label = UILabel()
        label.text = "Этаж"
        label.isHidden = true
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.backgroundColor = .black
        label.textColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let flatLabel: UILabel = {
        let label = UILabel()
        label.text = "Кв./Офис"
        label.isHidden = true
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.backgroundColor = .black
        label.textColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let intercomLabel: UILabel = {
        let label = UILabel()
        label.text = "Домофон"
        label.isHidden = true
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.backgroundColor = .black
        label.textColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Примечание к заказу"
        label.isHidden = true
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.backgroundColor = .black
        label.textColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1)
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
    
    func autolayoutSetup(vc: UIViewController) {
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.trailingAnchor),
            addressLabel.heightAnchor.constraint(equalToConstant: 20),
          
            addressButton.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: 20),
            addressButton.trailingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.trailingAnchor),
            addressButton.heightAnchor.constraint(equalToConstant: 50),
            addressButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor),
            
            porchLabel.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: 10),
            porchLabel.widthAnchor.constraint(equalToConstant: (vc.view.frame.size.width - 50)/4),
            porchLabel.heightAnchor.constraint(equalToConstant: 13),
            porchLabel.topAnchor.constraint(equalTo: addressButton.bottomAnchor, constant: 2),
            
            porchTextField.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: 10),
            porchTextField.widthAnchor.constraint(equalToConstant: (vc.view.frame.size.width - 50)/4),
            porchTextField.heightAnchor.constraint(equalToConstant: 35),
            porchTextField.topAnchor.constraint(equalTo: addressButton.bottomAnchor, constant: 15),
            
            floorLabel.leadingAnchor.constraint(equalTo: porchLabel.trailingAnchor,
                                                   constant: 10),
            floorLabel.widthAnchor.constraint(equalToConstant: (vc.view.frame.size.width - 50)/4),
            floorLabel.heightAnchor.constraint(equalToConstant: 13),
            floorLabel.topAnchor.constraint(equalTo: addressButton.bottomAnchor, constant: 2),
            
            floorTextField.leadingAnchor.constraint(equalTo: porchTextField.trailingAnchor,
                                                   constant: 10),
            floorTextField.widthAnchor.constraint(equalToConstant: (vc.view.frame.size.width - 50)/4),
            floorTextField.heightAnchor.constraint(equalToConstant: 35),
            floorTextField.topAnchor.constraint(equalTo: addressButton.bottomAnchor, constant: 15),
            
            flatLabel.leadingAnchor.constraint(equalTo: floorLabel.trailingAnchor,
                                                   constant: 10),
            flatLabel.widthAnchor.constraint(equalToConstant: (vc.view.frame.size.width - 50)/4),
            flatLabel.heightAnchor.constraint(equalToConstant: 13),
            flatLabel.topAnchor.constraint(equalTo: addressButton.bottomAnchor, constant: 2),
            
            flatTextField.leadingAnchor.constraint(equalTo: floorTextField.trailingAnchor,
                                                   constant: 10),
            flatTextField.widthAnchor.constraint(equalToConstant: (vc.view.frame.size.width - 50)/4),
            flatTextField.heightAnchor.constraint(equalToConstant: 35),
            flatTextField.topAnchor.constraint(equalTo: addressButton.bottomAnchor, constant: 15),
            
            intercomLabel.leadingAnchor.constraint(equalTo: flatLabel.trailingAnchor,
                                                   constant: 10),
            intercomLabel.widthAnchor.constraint(equalToConstant: (vc.view.frame.size.width - 50)/4),
            intercomLabel.heightAnchor.constraint(equalToConstant: 13),
            intercomLabel.topAnchor.constraint(equalTo: addressButton.bottomAnchor, constant: 2),
            
            intercomTextField.leadingAnchor.constraint(equalTo: flatTextField.trailingAnchor,
                                                   constant: 10),
            intercomTextField.widthAnchor.constraint(equalToConstant: (vc.view.frame.size.width - 50)/4),
            intercomTextField.heightAnchor.constraint(equalToConstant: 35),
            intercomTextField.topAnchor.constraint(equalTo: addressButton.bottomAnchor, constant: 15),
            
            commentsLabel.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: 20),
            commentsLabel.trailingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            commentsLabel.heightAnchor.constraint(equalToConstant: 13),
            commentsLabel.bottomAnchor.constraint(equalTo: commentsTextField.topAnchor, constant: 2),
            
            commentsTextField.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor,
                                                       constant: 20),
            commentsTextField.trailingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            commentsTextField.heightAnchor.constraint(equalToConstant: 35),
            commentsTextField.topAnchor.constraint(equalTo: porchTextField.bottomAnchor, constant: 35),
            
            saveButton.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor,
                                                       constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 52),
            saveButton.topAnchor.constraint(equalTo: commentsTextField.bottomAnchor, constant: 15)
        ])
    }
    
    private func setupView() {
        addSubview(addressLabel)
        addSubview(addressButton)
        addSubview(porchTextField)
        addSubview(floorTextField)
        addSubview(flatTextField)
        addSubview(intercomTextField)
        addSubview(commentsTextField)
        addSubview(saveButton)
        
        addSubview(porchLabel)
        addSubview(floorLabel)
        addSubview(flatLabel)
        addSubview(intercomLabel)
        addSubview(commentsLabel)
        
        commentsTextField.setBottomBorder()
        porchTextField.setBottomBorder()
        floorTextField.setBottomBorder()
        flatTextField.setBottomBorder()
        intercomTextField.setBottomBorder()
        
        porchAnimate()
        floorAnimate()
        flatAnimate()
        intercomAnimate()
        commentsAnimate()
    }
    
    private func porchAnimate() {
        porchTextField.addTarget(self, action: #selector(porchTextfieldChange), for: .editingChanged)
    }
    
    private func floorAnimate() {
        floorTextField.addTarget(self, action: #selector(floorTextfieldChange), for: .editingChanged)
    }
    
    private func flatAnimate() {
        flatTextField.addTarget(self, action: #selector(flatTextfieldChange), for: .editingChanged)
    }
    
    private func intercomAnimate() {
        intercomTextField.addTarget(self, action: #selector(intercomTextfieldChange), for: .editingChanged)
    }
    
    private func commentsAnimate() {
        commentsTextField.addTarget(self, action: #selector(commentsTextfieldChange), for: .editingChanged)
    }
    
    @objc private func commentsTextfieldChange() {
        animateTextfield(commentsTextField, commentsLabel)
    }
    
    @objc private func intercomTextfieldChange() {
        animateTextfield(intercomTextField, intercomLabel)
    }
    
    @objc private func flatTextfieldChange() {
        animateTextfield(flatTextField, flatLabel)
    }
    
    @objc private func floorTextfieldChange() {
        animateTextfield(floorTextField, floorLabel)
    }

    @objc private func porchTextfieldChange() {
        animateTextfield(porchTextField, porchLabel)
    }
    
    private func animateTextfield(_ textField: UITextField, _ label: UILabel) {
        guard let query = textField.text else {return}
        if !query.isEmpty && label.isHidden == true {
            UIView.transition(with: label,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                                label.isHidden = false
                              })
        } else if query.isEmpty && textField.isHidden == false {
            label.isHidden = true
        }
    }
    
}
