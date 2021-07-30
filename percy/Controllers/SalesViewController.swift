//
//  SalesViewController.swift
//  percy
//
//  Created by Антон Усов on 29.07.2021.
//

import UIKit

class SalesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(title: "Акции", image: UIImage(systemName: "cart"), tag: 0)
        self.tabBarItem = tabBarItem
//        tabBarItem.badgeColor = .white
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
