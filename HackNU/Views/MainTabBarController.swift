//
//  MainTabBarController.swift
//  HackNU
//
//  Created by Adlet Zeineken on 20.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    let navTitles = ["Home", "", "Profile"]
    let tabViewControllers: [UIViewController] = [HomeViewController(), CreateEventViewController(), ProfileViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.tintColor = Color.whiteBackground.withAlphaComponent(0.94)
                tabBar.isTranslucent = false
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.unselectedBlue], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.blue], for: .selected)
        let homeVC = HomeViewController()
        let createEventVC = CreateEventViewController()
        createEventVC.delegate = homeVC
        
        let homeNav = generateViewController(viewController: homeVC, title: "Home", image: UIImage(named: "home")!, selectedImage: UIImage(named: "home.selected")!)
        let createEventNav = generateViewController(viewController: createEventVC, title: "Create event", image: UIImage(named: "plus")!, selectedImage: UIImage(named: "plus.selected")!)
        
        let profileNav = generateViewController(viewController: ProfileViewController(), title: "Profile", image: UIImage(named: "person")!, selectedImage: UIImage(named: "person.selected")!)
        
        viewControllers = [homeNav, createEventNav, profileNav]
        
    }
    
    func generateViewController(viewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UINavigationController {
        viewController.navigationItem.title = title
        let navController = UINavigationController(rootViewController: viewController)
        if (title == "Home") {
            navController.navigationBar.prefersLargeTitles = true
        }
        navController.title = title
        navController.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        
        return navController
    }
    
}
