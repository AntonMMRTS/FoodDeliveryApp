//
//  Textfield+bottomBorder.swift
//  percy
//
//  Created by Антон Усов on 30.09.2021.
//

import UIKit

extension UITextField {
  func setBottomBorder() {
    self.borderStyle = .none
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor(red: 105/255, green: 104/255, blue: 110/255, alpha: 1).cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
  }
}
