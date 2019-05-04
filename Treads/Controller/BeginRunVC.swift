//
//  FirstViewController.swift
//  Treads
//
//  Created by Massimiliano on 23/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import MapKit

class BeginRunVC: LocationVC {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var lastRunCloseBtn: UIButton!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var lastRunBgView: UIView!
    @IBOutlet weak var lastRunStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
        
       // Run.getAllRuns()
        //print("here are my runs: \(Run.getAllRuns())")
    }

    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
        getLastRun()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func getLastRun(){
        guard let lastRun = Run.getAllRuns()?.first else {
            lastRunStack.isHidden = true
            lastRunBgView.isHidden = true
            lastRunCloseBtn.isHidden = true
            return
        }
        lastRunStack.isHidden = false
        lastRunBgView.isHidden = false
        lastRunCloseBtn.isHidden = false
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
    }
    
    
    @IBAction func locationCenterBtnPressed(_ sender: Any) {
    }
    
    
    @IBAction func LastRunCloseBtnPressed(_ sender: Any) {
        lastRunStack.isHidden = true
        lastRunBgView.isHidden = true
        lastRunCloseBtn.isHidden = true    }
    
    
}

extension BeginRunVC: CLLocationManagerDelegate{
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
    
    
    
}
