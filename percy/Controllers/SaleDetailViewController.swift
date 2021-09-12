//
//  SaleDetailViewController.swift
//  percy
//
//  Created by Антон Усов on 10.08.2021.
//

import UIKit

class SaleDetailViewController: UIViewController {
    
    var sale: Sale!
    
    private var saleView = SaleDetailView()

    override func loadView() {
       self.view = saleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentSaleSetup()
    }
    
    private func currentSaleSetup() {
        saleView.saleImage.image = sale.image
        saleView.nameLabel.text = sale.shortDefinition
        saleView.definitionLabel.text = sale.longDefinition
    }

}
