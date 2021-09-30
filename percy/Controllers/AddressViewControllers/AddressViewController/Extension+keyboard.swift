//
//  Extension+keyboard.swift
//  percy
//
//  Created by Антон Усов on 30.09.2021.
//


import UIKit

extension AddressViewController {
    
    func addKeyboardSubscription() {
        NotificationCenter.default.addObserver(self, selector: #selector(showkb), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hidekb), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func cancelKeyboardSubscription() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func showkb(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardY = self.view.frame.height - keyboardSize.height
        let editingTetxFieldY = activeTextField.convert(activeTextField.bounds, to: self.view).minY
        
        if self.view.frame.minY >= 0 {
            if editingTetxFieldY > keyboardY {
                UIView.animate(withDuration: 0.25,
                               delay: 0,
                               options: UIView.AnimationOptions.curveEaseIn,
                               animations: {
                                self.view.frame = CGRect(x: 0,
                                                         y: self.view.frame.origin.y - (editingTetxFieldY - (keyboardY - 50)),
                                                         width: self.view.bounds.width,
                                                         height: self.view.bounds.height)
                               }, completion: nil)
            }
        }
    }
    
    @objc private func hidekb(_ notification: Notification) {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.view.frame = CGRect(x: 0,
                                                 y: 0,
                                                 width: self.view.bounds.width,
                                                 height: self.view.bounds.height)
                       }, completion: nil)
    }
    
}

