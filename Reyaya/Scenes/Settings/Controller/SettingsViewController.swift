//
//  SettingsViewController.swift
//  Reyaya
//
//  Created by Peter Bassem on 7/30/19.
//  Copyright © 2019 Peter Bassem. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarItems(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "settingsTab", comment: ""))
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        ActivityIndicatorManager.shared.showProgressView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            user = nil
            appDelegate?.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login_view_controller") as? LoginViewController
            appDelegate?.window?.makeKeyAndVisible()
            ActivityIndicatorManager.shared.hideProgressView()
        }
    }
}
