//
//  SalesViewController.swift
//  percy
//
//  Created by Антон Усов on 29.07.2021.
//

import UIKit

class SalesViewController: UIViewController {
    
    private var sales: [Sale] = []
    
    private var firebaseManager = FirebaseManager()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(SaleCell.self, forCellReuseIdentifier: SaleCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
       
        firebaseManager.sales(tableView: tableView) { (newSales) in
            self.sales = newSales
            self.tableView.reloadData()
        }
    }
    
    private func configure() {
        view.backgroundColor = .black
        
        self.tabBarItem = UITabBarItem(title: "Акции", image: UIImage(systemName: "cart"), tag: 0)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }
    
}

extension SalesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SaleCell.identifier,
                                                 for: indexPath) as! SaleCell
        cell.sale = sales[indexPath.row]
        
        return cell
    }
    
}
