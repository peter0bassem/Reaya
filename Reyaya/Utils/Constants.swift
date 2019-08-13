//
//  VARIABLES.swift
//  The Avenue Agent
//
//  Created by iMac on 7/19/18.
//  Copyright © 2018 Ashraf Essam. All rights reserved.
//

import Foundation
import UIKit


let userDefaults = UserDefaults.standard
let appDelegate = UIApplication.shared.delegate as? AppDelegate

var user: User?

class DateFormats {
    private static var instance: DateFormats? = nil

    static func getInstance() -> DateFormats {
        if instance == nil {
            instance = DateFormats()
        }
        return instance!
    }

    private init() {

    }

    //Date Formats
    let dateFormatter = DateFormatter()
    let enSlachStringDateFormat = "dd/MM/yyyy"
    let arSlachStringDateFormat = "yyyy/MM/dd"
    let enDashStringDateFormat = "dd-MM-yyyy"
    let timeFormat = "hh:mm:ss a"

    let fullEnDashStringDateFormat = "dd-MM-yyyy hh:mm:ss a"
}
