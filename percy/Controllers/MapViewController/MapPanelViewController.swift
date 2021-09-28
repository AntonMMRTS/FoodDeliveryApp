//
//  MapPanelViewController.swift
//  percy
//
//  Created by Антон Усов on 25.09.2021.
//

import UIKit
import CoreLocation


class MapPanelViewController: UIViewController {
    
    private var locations = [Location]()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = .black
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var completion: (() -> Void)?
    
    let addressButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(addressLabel)
        view.addSubview(addressButton)
        showSearch()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addressLabel.heightAnchor.constraint(equalToConstant: 20),
          
            addressButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: 20),
            addressButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addressButton.heightAnchor.constraint(equalToConstant: 50),
            addressButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor)
        ])
    }
    
    @objc private func showSearchController() {
        completion?()
    }
    
    private func showSearch() {
        addressButton.addTarget(self, action: #selector(showSearchController), for: .touchUpInside)
    }
    
}


