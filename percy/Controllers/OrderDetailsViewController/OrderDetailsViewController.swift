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
        title = "Ваш заказ"
        navigationController?.navigationBar.tintColor = .white

        orderView.sumLabel.text = "\(totalSum!) ₽"
        
        orderView.tableView.delegate = self
        orderView.tableView.dataSource = self
        
        orderView.addressTetxField.delegate = self
        orderView.commentTetxField.delegate = self
    }

    private func doOrder() {
        orderView.orderButton.addTarget(self, action: #selector(addOrder), for: .touchUpInside)
    }

}

extension OrderDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.identifier, for: indexPath) as! OrderCell
        let product = products[indexPath.row]
        cell.product = product
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
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
