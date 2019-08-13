//
//  TabBarController.swift
//  CorpyEcommerce
//
//  Created by Peter Bassem on 11/8/18.
//  Copyright © 2018 corpy. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK:- Outlets
//    @IBOutlet weak var tabbar: UITabBar!
    
    //MARK:- Properties
    var  controllers = [UIViewController]()

    //MARK:- Main Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let homeNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_navigation_controller") as? UINavigationController else { return }
        let homeTabBarItem = UITabBarItem(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "homeTab", comment: ""), image: #imageLiteral(resourceName: "home"), selectedImage: nil)
        homeTabBarItem.tag = 0
        homeTabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : setFont(size: 16, isBold: false)], for: UIControl.State.normal)
        homeTabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : setFont(size: 16, isBold: true)], for: UIControl.State.selected)
//        homeTabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        homeNavigationController.tabBarItem = homeTabBarItem
        
        guard let hospitalsNaviagationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hospitals_navigation_controller") as? UINavigationController else { return }
        let hostpitalsTabBarItem = UITabBarItem(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "hospitalsTab", comment: ""), image: #imageLiteral(resourceName: "hospital"), selectedImage: nil)
        hostpitalsTabBarItem.tag = 1
        hostpitalsTabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : setFont(size: 16, isBold: false)], for: UIControl.State.normal)
        hostpitalsTabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : setFont(size: 16, isBold: true)], for: UIControl.State.selected)
//        hostpitalsTabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        hospitalsNaviagationController.tabBarItem = hostpitalsTabBarItem
        
        guard let pharmaciesNaviagationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pharmacies_navigation_controller") as? UINavigationController else { return }
        let pharmaciesTabBarItem = UITabBarItem(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "pharmaciesTab", comment: ""), image: #imageLiteral(resourceName: "pharmacies"), selectedImage: nil)
        pharmaciesTabBarItem.tag = 2
        pharmaciesTabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : setFont(size: 16, isBold: false)], for: UIControl.State.normal)
        pharmaciesTabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : setFont(size: 16, isBold: true)], for: UIControl.State.selected)
//        pharmaciesTabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        pharmaciesNaviagationController.tabBarItem = pharmaciesTabBarItem
        
        guard let settingsNaviagationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settings_navigation_controller") as? UINavigationController else { return }
        let settingsTabBarItem = UITabBarItem(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "settingsTab", comment: ""), image: #imageLiteral(resourceName: "settings"), selectedImage: nil)
        settingsTabBarItem.tag = 3
        settingsTabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : setFont(size: 16, isBold: false)], for: UIControl.State.normal)
        settingsTabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : setFont(size: 16, isBold: true)], for: UIControl.State.selected)
//        settingsTabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        settingsNaviagationController.tabBarItem = settingsTabBarItem
        
        controllers = [homeNavigationController, hospitalsNaviagationController, pharmaciesNaviagationController, settingsNaviagationController]
        
        self.viewControllers = controllers
        tabBar.tintColor = COLORS.mainColor
        self.selectedIndex = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
