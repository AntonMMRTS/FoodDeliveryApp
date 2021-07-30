//
//  SceneDelegate.swift
//  percy
//
//  Created by Антон Усов on 29.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        
        let firstVC = MenuViewController()
        let secondVC = SalesViewController()
        let thirdVC = OrdersViewController()
        let fourthVC = BasketViewController()
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        let fourthNav = UINavigationController(rootViewController: fourthVC)
        
        firstVC.navigationController?.navigationBar.barTintColor = .black
        secondVC.navigationController?.navigationBar.barTintColor = .black
        thirdVC.navigationController?.navigationBar.barTintColor = .black
        fourthVC.navigationController?.navigationBar.barTintColor = .black
        
        firstNav.title = "Меню"
        secondVC.title = "Акции"
        thirdVC.title = "Мои заказы"
        fourthVC.title = "Корзина"
        
        let tabBar = UITabBarController()

//        tabBar.tabBar.isTranslucent = false;
        tabBar.tabBar.tintColor = .white
//        tabBar.tabBar.barTintColor = .white
        tabBar.setViewControllers([firstNav, secondNav, thirdNav, fourthNav], animated: true)
        tabBar.tabBar.barTintColor = .black
        
        guard let items = tabBar.tabBar.items else { return }
        items.last?.badgeValue = "1"
        let images = ["folder", "percent", "arrow.counterclockwise", "cart"]
        
        for icon in 0..<items.count {
            items[icon].image = UIImage(systemName: images[icon])
        }
        
        self.window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

