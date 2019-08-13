//
//  HomeViewController+MKMapViewDelegate.swift
//  Reyaya
//
//  Created by Peter Bassem on 7/30/19.
//  Copyright © 2019 Peter Bassem. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if manager.location != nil {
            manager.delegate = nil
        }
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude), \(locValue.longitude)")
        
        
        getAddressFromLatLon(pdblLatitude: String(locValue.latitude), withLongitude: String(locValue.longitude)) { (address) in
            self.addressLabel.text = address
        }
    }
    
    
}
