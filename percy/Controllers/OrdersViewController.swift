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
    
    private let myOrderManager = MyOrderRealmManager()
    
    private var orders: Results<MyOrder>!
    
    override func loadView() {
       self.view = myOrder
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orders = myOrderManager.obtainOrders()

        myOrder.myOrdersCollectionView.dataSource = self
        myOrder.myOrdersCollectionView.delegate = self
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
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
        return cell
    }
    
}

extension OrdersViewController: UICollectionViewDelegateFlowLayout {
    
    // задаем размеры нашей ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
        }
}
