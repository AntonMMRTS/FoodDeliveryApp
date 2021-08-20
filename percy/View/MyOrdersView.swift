//
//  MyOrdersView.swift
//  percy
//
//  Created by Антон Усов on 18.08.2021.
//

import UIKit

class MyOrdersView: UIView {
    
    var myOrdersCollectionView: UICollectionView!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
    }
    
    private func setupCollectionView() {

        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical
       
        myOrdersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout1)
        myOrdersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myOrdersCollectionView.backgroundColor = .black
        myOrdersCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        myOrdersCollectionView.register(MyOrdersCell.self,
                                        forCellWithReuseIdentifier: MyOrdersCell.identifier)

        addSubview(myOrdersCollectionView)
        
        myOrdersCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        myOrdersCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        myOrdersCollectionView.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor).isActive = true
        myOrdersCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
    }
}
