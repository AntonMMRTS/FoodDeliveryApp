//
//  MapPanelViewController.swift
//  percy
//
//  Created by Антон Усов on 25.09.2021.
//

import UIKit


class MapPanelViewController: UIViewController {
    
    private var locations = [Location]()
    
    var completionTextfield: ((UITextField) -> Void)?
    
    var completion: (() -> Void)?
    
    let mapPanelView = MapPanelView()
    
    override func loadView() {
        self.view = mapPanelView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        mapPanelView.commentsTextField.delegate = self
        mapPanelView.intercomTextField.delegate = self
        mapPanelView.porchTextField.delegate = self
        mapPanelView.floorTextField.delegate = self
        mapPanelView.flatTextField.delegate = self
        
        showSearchVC()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapPanelView.setupLayout(vc: self)
    }

    private func showSearchVC() {
        mapPanelView.addressButton.addTarget(self, action: #selector(showSearchController), for: .touchUpInside)
    }
    
    @objc private func showSearchController() {
        completion?()
    }

}

extension MapPanelViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        completionTextfield?(textField)
    }

}



