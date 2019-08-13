//
//  PharmaciesViewController.swift
//  Reyaya
//
//  Created by Peter Bassem on 7/30/19.
//  Copyright © 2019 Peter Bassem. All rights reserved.
//

import UIKit

class PharmaciesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarItems(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "pharmaciesTab", comment: ""))
    }
}
