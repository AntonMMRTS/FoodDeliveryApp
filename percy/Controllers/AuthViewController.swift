//
//  AuthViewController.swift
//  percy
//
//  Created by Антон Усов on 12.08.2021.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber

class AuthViewController: UIViewController {
    
    private var listController: FPNCountryListViewController!
    
    private var phoneNumber: String?
    
    private let authView = AuthView()
    
    override func loadView() {
        self.view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSMSAction()
        setupConfig()
        
        authView.setupView()
        navigationControllerSetup()
    }
    
    private func navigationControllerSetup() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Авторизация"
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func getSMSAction() {
        authView.getCodeButton.addTarget(self, action: #selector(fetchCodeTapped), for: .touchUpInside)
    }
    
    @objc private func fetchCodeTapped() {
        
        guard phoneNumber != nil else { return }
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) {
            [weak self] (verificationID, error) in
            if error != nil {
                print(error?.localizedDescription ?? "is empty")
            } else {
                self?.showSMSViewController(id: verificationID! )
            }
        }
    }
    
    private func showSMSViewController(id: String) {
        
        let vc = SMSViewController()
        vc.id = id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConfig() {
        authView.phoneTetxField.delegate = self
        
        listController = FPNCountryListViewController(style: .grouped)
        listController?.setup(repository: authView.phoneTetxField.countryRepository)
        
        authView.phoneTetxField.becomeFirstResponder()
        
        listController.didSelect = { [weak self] country in
            self?.authView.phoneTetxField.setFlag(countryCode: country.code)
        }
    }
    
}

extension AuthViewController: FPNTextFieldDelegate {
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            authView.getCodeButton.isHidden = false
            phoneNumber = textField.getFormattedPhoneNumber(format: .International)
        } else {
            authView.getCodeButton.isHidden = true
        }
    }
    
    func fpnDisplayCountryList() {
        let navigationController = UINavigationController(rootViewController: listController)
        listController.title = "Страны"
        authView.phoneTetxField.text = ""
        self.present(navigationController, animated: true, completion: nil)
    }
}

