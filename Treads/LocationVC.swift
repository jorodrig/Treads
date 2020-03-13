//
//  LocationVC.swift
//  Treads
//
//  Created by Jacob Luetzow on 6/16/17.
//  Copyright © 2017 Jacob Luetzow. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, MKMapViewDelegate {
    
    var manager: CLLocationManager?
    
    override func viewDidLoad() {
        print("In LocationVC.swift viewDidLoad()")
        super.viewDidLoad()
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.activityType = .fitness
    }
    
    func checkLocationAuthStatus() {
        print("In ceckLocationAuthStatus in LocationVC.swift")
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            manager?.requestWhenInUseAuthorization()
        }
    }


}
