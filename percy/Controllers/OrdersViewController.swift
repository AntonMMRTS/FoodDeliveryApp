//
//  OrdersViewController.swift
//  percy
//
//  Created by Антон Усов on 29.07.2021.
//

import UIKit
import RealmSwift

class OrdersViewController: UIViewController {
    
    private let myOrderManager = MyOrderRealmManager()
    
    private var orders: Results<MyOrder>!
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(MyOrdersCell.self, forCellReuseIdentifier: MyOrdersCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        self.orders = myOrderManager.obtainOrders()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyOrdersCell.identifier, for: indexPath) as! MyOrdersCell
        
        let order = orders[indexPath.row]
        cell.configure(order: order)
        
        return cell
    }
    
}
