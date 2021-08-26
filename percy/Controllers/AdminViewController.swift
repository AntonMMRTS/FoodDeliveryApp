//
//  AdminViewController.swift
//  percy
//
//  Created by Антон Усов on 25.08.2021.
//

import UIKit

class AdminViewController: UIViewController {

    private var orders: [AdminOrder] = []
    
    private var firebaseManager = AdminOrderManager()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(AdminOrderCell.self, forCellReuseIdentifier: AdminOrderCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
       
        firebaseManager.getOrders(tableView: tableView) { [weak self] newOrders in
            self?.orders = newOrders
            self?.tableView.reloadData()
        }
    }
    
    private func configure() {

        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white

        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }
    
}

extension AdminViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdminOrderCell.identifier,
                                                 for: indexPath) as! AdminOrderCell

        let order = orders[indexPath.row]
        cell.configure(order: order)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = SaleDetailViewController()
//
//        vc.sale = sales[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
//    }
    
}
    

   


