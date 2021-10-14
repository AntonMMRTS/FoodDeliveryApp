//
//  OrderDetailsViewController.swift
//  percy
//
//  Created by Антон Усов on 13.08.2021.
//

import UIKit
import Firebase
import FirebaseDatabase


class OrderDetailsViewController: UIViewController {
    
    var products: [Product]!
    
    var totalSum: Int!
    
    var activeTextField: UITextField!
    
    let orderView = OrderView()
    
    let currentUser = Auth.auth().currentUser
    
    let db = Firestore.firestore()
    
    let databaseManager: DatabaseManagerProtocol = RealmManager()
    
    let myOrderManager = MyOrderRealmManager()
    
    override func loadView() {
        self.view = orderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        initializeHideKeyboard()
      
        doOrder()
        
        setupAddress()
        
        orderView.payButton.addTarget(self, action: #selector(alertPay), for: .touchUpInside)
        orderView.whenButton.addTarget(self, action: #selector(alertTime), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardSubscription()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancelKeyboardSubscription()
    }

    private func configure() {
        view.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        orderView.sumLabel.text = "\(totalSum!) ₽"
        
        orderView.commentTetxField.delegate = self
    }

    private func doOrder() {
        orderView.orderButton.addTarget(self, action: #selector(addOrder), for: .touchUpInside)
    }
    
    private func setupAddress() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(OrderDetailsViewController.showMap(recognizer:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        orderView.addressLabel.isUserInteractionEnabled = true
        
        orderView.addressLabel.addGestureRecognizer(tap)
    }
    
    @objc private func showMap(recognizer: UITapGestureRecognizer) {
        let vc = AddressViewController()
        vc.completion = { [weak self] address in
            self?.orderView.addressLabel.textAlignment = .left
            self?.orderView.addressLabel.text = address
        }
        print("Anton")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func alertPay() {
        let alert = UIAlertController(title: "Способ оплаты", message: nil, preferredStyle: .actionSheet)
        let actionCardOnline = UIAlertAction(title: "Картой онлайн", style: .default, handler: nil)
        let actionCardOffline = UIAlertAction(title: "Картой при получении", style: .default, handler: nil)
        let actionApplePay = UIAlertAction(title: "Apple Pay", style: .default, handler: nil)
        let actionCash = UIAlertAction(title: "Наличными", style: .default, handler: nil)
        
        alert.addAction(actionCardOnline)
        alert.addAction(actionCardOffline)
        alert.addAction(actionApplePay)
        alert.addAction(actionCash)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func alertTime() {
        let alert = UIAlertController(title: "Время доставки", message: nil, preferredStyle: .actionSheet)
        let actionCardOnline = UIAlertAction(title: "Как можно быстрее", style: .default, handler: nil)
        let actionCardOffline = UIAlertAction(title: "Ко времени", style: .default, handler: nil)
        
        alert.addAction(actionCardOnline)
        alert.addAction(actionCardOffline)
        
        present(alert, animated: true, completion: nil)
    }

}


extension OrderDetailsViewController {
    
    private func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    
}

extension OrderDetailsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
}
