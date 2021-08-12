//
//  SMSViewController.swift
//  percy
//
//  Created by Антон Усов on 12.08.2021.
//

import UIKit
import Firebase

class SMSViewController: UIViewController {
    
    var id: String!
    
    private let db = Firestore.firestore()
    
    private var smsView = SMSView()
    
    private var phoneNumber: String!
    
    override func loadView() {
        self.view = smsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationControllerSetup()
        
        checkCode()
        
        smsView.setupView()
        
        setupConfig()
    }
    
    private func navigationControllerSetup() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        title = "Введите код"
    }
    
    private func checkCode() {
        smsView.checkCodeButton.addTarget(self, action: #selector(checkCodeTapped), for: .touchUpInside)
    }
    
    @objc private func checkCodeTapped() {
        guard let code = smsView.codeTetxView.text else { return }
        
        let credetional = PhoneAuthProvider.provider().credential(withVerificationID: id,
                                                                  verificationCode: code)
        
        Auth.auth().signIn(with: credetional) { [weak self] (_, error) in
            if error != nil {
                let ac = UIAlertController(title: error?.localizedDescription,
                                           message: nil,
                                           preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                ac.addAction(cancel)
                self?.present(ac, animated: true, completion: nil)
            } else {
                let ac = UIAlertController(title: "Авторизация прошла успешно",
                                           message: nil,
                                           preferredStyle: .alert)
                let can = UIAlertAction(title: "Ok", style: .cancel) { [weak self] _ in
                    
                    let currentUser = Auth.auth().currentUser
                    self?.db.collection("users")
                        .document(currentUser!.phoneNumber!)
                        .setData(["uid" : currentUser!.uid, "phoneNumber" : currentUser!.phoneNumber!])
                    self?.showMenu()
                }
                ac.addAction(can)
                self?.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    private func showMenu() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupConfig() {
        smsView.checkCodeButton.alpha = 0.5
        smsView.checkCodeButton.isEnabled = false
        
        smsView.codeTetxView.delegate = self
        smsView.codeTetxView.becomeFirstResponder()
    }
    
}

extension SMSViewController: UITextViewDelegate {
    // ограничим количество символов
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + text.count - range.length
        return newLength <= 6
    }
    
    // блокируем кнопку
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 6 {
            smsView.checkCodeButton.alpha = 1
            smsView.checkCodeButton.isEnabled = true
        } else {
            smsView.checkCodeButton.alpha = 0.5
            smsView.checkCodeButton.isEnabled = false
        }
    }
}
