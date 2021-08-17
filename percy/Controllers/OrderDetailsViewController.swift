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
    
    var activeTextField: UITextField!
    
    var products: [Product]!
    
    var totalSum: Int!
    
    private let orderView = OrderView()
    
    private let currentUser = Auth.auth().currentUser
    
    private let db = Firestore.firestore()
    
    private let databaseManager: DatabaseManagerProtocol = RealmManager()
    
    override func loadView() {
        self.view = orderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showkb), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hidekb), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        orderView.addressTetxField.delegate = self
        orderView.commentTetxField.delegate = self
        
        configure()
        
        initializeHideKeyboard()
        
        orderView.setupView()
      
        doOrder()
    }
    
    @objc func showkb(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardY = self.view.frame.height - keyboardSize.height
        let editingTetxFieldY = activeTextField.convert(activeTextField.bounds, to: self.view).minY
        
        if self.view.frame.minY >= 0 {
            if editingTetxFieldY > keyboardY {
                UIView.animate(withDuration: 0.25,
                                        delay: 0,
                                        options: UIView.AnimationOptions.curveEaseIn,
                                        animations: {
                                            self.view.frame = CGRect(x: 0,
                                                                     y: self.view.frame.origin.y - (editingTetxFieldY - (keyboardY - 50)),
                                                                     width: self.view.bounds.width,
                                                                     height: self.view.bounds.height)
                                            print("editingTextField - \(editingTetxFieldY)")
                                           
                                        }, completion: nil)
            }
        }
    }
    
    @objc func hidekb(_ notification: Notification) {
        UIView.animate(withDuration: 0.25,
                                delay: 0,
                                options: UIView.AnimationOptions.curveEaseIn,
                                animations: {
                                    self.view.frame = CGRect(x: 0,
                                                             y: 0,
                                                             width: self.view.bounds.width,
                                                             height: self.view.bounds.height)
                                }, completion: nil)
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
    
    @objc private func addOrder() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        let dbDestination = self.db.collection("users")
            .document(currentUser!.phoneNumber!)
            .collection("orders")
            .document(formatter.string(from: Date()))
        
//        self.db.collection("users")
//            .document(currentUser!.phoneNumber!)
//            .collection("orders")
//            .document(formatter.string(from: Date()))
        dbDestination.setData(["date" : formatter.string(from: Date()), "sum" : totalSum!, "adress" : orderView.addressTetxField.text!])
        
        for product in products {
//            self.db.collection("users")
//                .document(currentUser!.phoneNumber!)
//                .collection("orders")
//                .document(formatter.string(from: Date()))
            dbDestination.collection("order")
                .document(product.name + " \(product.quantity) шт")
                .setData(["name" : product.name, "amount" : product.quantity])
            
            db.collection("orders")
                .document(currentUser!.phoneNumber!)
                .collection("order")
                .document(product.name + " \(product.quantity) шт")
                .setData(["name" : product.name, "amount" : product.quantity])
            
            databaseManager.deleteProduct(product: product)
        }
        
        db.collection("orders")
            .document(currentUser!.phoneNumber!)
            .setData([
                        "adress" : orderView.addressTetxField.text!,
                        "comment" : orderView.commentTetxField.text!,
                        "persons" : 2,
                        "sum" : totalSum!,
                        "time" : "now",
                        "date" : formatter.string(from: Date()),
                        "phone" : currentUser!.phoneNumber!])
        
        tabBarController?.tabBar.items?.last?.badgeValue = nil
        print("You did order")
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
    
    func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
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
