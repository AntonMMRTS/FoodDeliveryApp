//
//  MenuView.swift
//  percy
//
//  Created by Антон Усов on 03.08.2021.
//

import UIKit

class MenuView: UIView {
    
    var selectedGroupIndex = 0
    
    var categoryCollectionView: UICollectionView!
    var menuCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCategoryCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
        setupCategoryCollectionView()
    }
    
    func setupCategoryCollectionView() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.backgroundColor = .black

        categoryCollectionView.register(CategoryCell.self,
                                        forCellWithReuseIdentifier: CategoryCell.identifier)

        addSubview(categoryCollectionView)
        
        categoryCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        categoryCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        categoryCollectionView.heightAnchor.constraint(equalToConstant: 55).isActive = true

        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical

        menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout1)
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        menuCollectionView.backgroundColor = .black
        menuCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        menuCollectionView.register(MenuCell.self,
                                        forCellWithReuseIdentifier: MenuCell.identifier)


        addSubview(menuCollectionView)
        menuCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor).isActive = true
        menuCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        menuCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        menuCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
