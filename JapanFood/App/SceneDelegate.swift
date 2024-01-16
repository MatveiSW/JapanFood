//
//  SceneDelegate.swift
//  JapanFood
//
//  Created by Матвей Авдеев on 16.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let foodVC = FoodListViewController()
        let oneMockVC = OneMockeViewController()
        let twoMockVC = TwoMockViewController()
        
        let tabBarController = UITabBarController()
        
        foodVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "list"), tag: 0)
        oneMockVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "basket"), tag: 0)
        twoMockVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "info"), tag: 0)
        
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: foodVC),
            UINavigationController(rootViewController: oneMockVC),
            UINavigationController(rootViewController: twoMockVC)
        ]
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
        
        tabBarController.tabBar.backgroundColor = .black
        tabBarController.tabBar.tintColor = .systemYellow
        tabBarController.tabBar.unselectedItemTintColor = .white
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

