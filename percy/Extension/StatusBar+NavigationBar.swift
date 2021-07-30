//
//  StatusBar+NavigationBar.swift
//  percy
//
//  Created by Антон Усов on 29.07.2021.
//

import UIKit

// высота navigationBar и statusBar
extension UIViewController {

    var navigationBarHeight: CGFloat {
//        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
//            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        return self.navigationController?.navigationBar.frame.height ?? 0.0
    }
    
    var statusBarHeight: CGFloat {
        let viewController = UIApplication.shared.windows.first!.rootViewController
        return viewController!.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
      
    }
    
}
