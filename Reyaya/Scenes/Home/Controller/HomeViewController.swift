//
//  HomeViewController.swift
//  Reyaya
//
//  Created by Peter Bassem on 7/30/19.
//  Copyright © 2019 Peter Bassem. All rights reserved.
//

import UIKit
import Pulsator
import CoreLocation
//import Contacts

class HomeViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var callAmbulanceViewButton: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var autoDetectButton: UIButton!
    
    let pulsator: Pulsator = {
        let pulsator = Pulsator()
        return pulsator
    }()
    
    var manager: CLLocationManager?
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarItems(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "homeTab", comment: ""))
        
        if let user = user {
            usernameLabel.text = "Hi, \(user.fname) \(user.lname)"
        }
        
        setupCallAmbulanceView()
        setupLocationManager()
        
        addressLabel.numberOfLines = 0
        
        autoDetectButton.moveImageLeftTextCenter(image: #imageLiteral(resourceName: "gps"), imagePadding: 45, renderingMode: .alwaysOriginal)
        autoDetectButton.layer.cornerRadius = 10
        autoDetectButton.clipsToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.layoutIfNeeded()
        pulsator.position = callAmbulanceViewButton.layer.position
    }
    
    fileprivate func setupCallAmbulanceView() {
        callAmbulanceViewButton.backgroundColor = .red
        callAmbulanceViewButton.layer.cornerRadius = callAmbulanceViewButton.frame.width / 2
        callAmbulanceViewButton.clipsToBounds = true
        
        callAmbulanceViewButton.layer.superlayer?.insertSublayer(pulsator, below: callAmbulanceViewButton.layer)
        //        callAmbulanceViewButton.layer.addSublayer(pulsator)
        setupInitialValues()
        pulsator.start()
    }
    
    fileprivate func setupInitialValues() {
        pulsator.numPulse = 5
        pulsator.radius =  140
        pulsator.animationDuration = 10
        pulsator.backgroundColor = UIColor(
            red: CGFloat(1),
            green: CGFloat(0),
            blue: CGFloat(0),
            alpha: CGFloat(1)).cgColor
    }
    
    fileprivate func setupLocationManager() {
        manager = CLLocationManager()
        manager?.requestAlwaysAuthorization()
        manager?.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            manager?.delegate = self
            manager?.desiredAccuracy = kCLLocationAccuracyBest
            manager?.startUpdatingLocation()
        }
    }
    
    func geocode(latitude: Double, longitude: Double, completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemark, error in
            guard let placemark = placemark, error == nil else {
                completion(nil, error)
                return
            }
            completion(placemark, nil)
        }
    }
    
    internal func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String, completion: @escaping (String) -> Void) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
                    print(addressString)
                    completion(addressString)
                }
        })
    }
    
    @IBAction func autoDetectButtonPressed(_ sender: UIButton) {
    }
}
