//
//  LocationVC.swift
//  Treads
//
//  Created by Massimiliano on 24/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationVC: UIViewController, MKMapViewDelegate {
    
    //MARK: - Properties

    var manager: CLLocationManager?

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.activityType = .fitness
    }
    
    //MARK: - Methods

    func checkLocationAuthStatus(){
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse{
            manager?.requestWhenInUseAuthorization()
        }
    }
}
