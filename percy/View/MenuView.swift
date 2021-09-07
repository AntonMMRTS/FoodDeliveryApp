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
    
    private func setupCategoryCollectionView() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.backgroundColor = .black
        categoryCollectionView.register(CategoryCell.self,
                                        forCellWithReuseIdentifier: CategoryCell.identifier)

        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical

        menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout1)
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        menuCollectionView.backgroundColor = .black
        menuCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        menuCollectionView.register(MenuCell.self,
                                        forCellWithReuseIdentifier: MenuCell.identifier)

        addSubview(categoryCollectionView)
        addSubview(menuCollectionView)
        
        NSLayoutConstraint.activate([
        categoryCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        categoryCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        categoryCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        categoryCollectionView.heightAnchor.constraint(equalToConstant: 55),
        
        menuCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
        menuCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        menuCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        menuCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
