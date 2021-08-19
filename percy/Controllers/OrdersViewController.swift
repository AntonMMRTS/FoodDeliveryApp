//
//  OrdersViewController.swift
//  percy
//
//  Created by Антон Усов on 29.07.2021.
//

import UIKit
import RealmSwift

class OrdersViewController: UIViewController {
    
    let myOrder = MyOrdersView()
    
    let myOrderManager = MyOrderRealmManager()
    
    var orders: Results<MyOrder>!
    
    override func loadView() {
       self.view = myOrder
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orders = myOrderManager.obtainOrders()

        myOrder.myOrdersCollectionView.dataSource = self
        myOrder.myOrdersCollectionView.delegate = self
        
    }

}

extension OrdersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyOrdersCell.identifier, for: indexPath) as! MyOrdersCell
        let order = orders[indexPath.item]
        cell.configure(order: order)
        print(orders.first?.products)
        return cell
    }
    
}

extension OrdersViewController: UICollectionViewDelegateFlowLayout {
    
    // задаем размеры нашей ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 100)
        }
}
