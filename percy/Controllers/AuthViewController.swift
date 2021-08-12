//
//  AuthViewController.swift
//  percy
//
//  Created by Антон Усов on 12.08.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    let authView = AuthView()
    
    override func loadView() {
       self.view = authView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        authView.setupView()
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Авторизация"
        navigationController?.navigationBar.barStyle = .black
    }
}
