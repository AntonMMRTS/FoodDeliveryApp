//
//  MapPanelViewController.swift
//  percy
//
//  Created by Антон Усов on 30.09.2021.
//
import UIKit

class MapPanelViewController: UIViewController {

    var completionTextfield: ((UITextField) -> Void)?
    
    var completionAddress: ((String) -> Void)?
    
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
        setAddress()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapPanelView.autolayoutSetup(vc: self)
    }

    private func showSearchVC() {
        mapPanelView.addressButton.addTarget(self, action: #selector(showSearchController), for: .touchUpInside)
    }
    
    @objc private func showSearchController() {
        completion?()
    }
    
    private func setAddress() {
        mapPanelView.saveButton.addTarget(self, action: #selector(saveAddress), for: .touchUpInside)
    }
    
    @objc private func saveAddress() {
        guard let address = mapPanelView.addressButton.titleLabel?.text else { return }
        
        guard let flat = mapPanelView.flatTextField.text, !flat.isEmpty else {
            completionAddress?(address)
            navigationController?.popViewController(animated: true)
            return
        }
        
        let fullAddress = "\(address), кв.\(flat)"
        completionAddress?(fullAddress)
        navigationController?.popViewController(animated: true)
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
