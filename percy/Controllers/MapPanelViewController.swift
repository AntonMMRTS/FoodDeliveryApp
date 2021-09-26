//
//  MapPanelViewController.swift
//  percy
//
//  Created by Антон Усов on 25.09.2021.
//

import UIKit
import CoreLocation

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController(_ vc: MapPanelViewController,
                              didSelectLocationWith coordinates: CLLocationCoordinate2D?)
}

class MapPanelViewController: UIViewController {
    
    weak var delegate: SearchViewControllerDelegate?
    
    private var locations = [Location]()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Адрес"
        return label
    }()
    
    let addressButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 9
        button.backgroundColor = .tertiarySystemBackground
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(label)
        view.addSubview(addressButton)
        showSearch()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: 10, width: label.frame.size.width, height: label.frame.size.height)
        addressButton.frame = CGRect(x: 10, y: 20 + label.frame.size.height,
                                     width: view.frame.size.width - 20, height: 50)
    }
    
    @objc private func showSearchController() {
        let vc = SearchAddressViewController()
        present(vc, animated: true)
    }
    
    private func showSearch() {
        addressButton.addTarget(self, action: #selector(showSearchController), for: .touchUpInside)
    }
    
}


