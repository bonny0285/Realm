//
//  FirstViewController.swift
//  Treads
//
//  Created by Massimiliano on 23/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class BeginRunVC: LocationVC {

    //MARK: - Outlets

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lastRunCloseBtn: UIButton!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var lastRunBgView: UIView! {
        didSet {
            lastRunBgView.backgroundColor = .black.withAlphaComponent(0.4)
        }
    }
    @IBOutlet weak var lastRunStack: UIStackView!
    
    //MARK: - Properties

    var render = MKPolylineRenderer()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = self
        checkLocationAuthStatus()
        //setupMapView()
    }

    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        mapView.delegate = self
        manager?.startUpdatingLocation()
        //getLastRun()
        //setupMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMapView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    //MARK: - Methods

    func setupMapView() {
        if let overlay = addLastRunToMap() {
             if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.addOverlay(overlay)
            mapView.renderer(for: overlay)
            lastRunStack.isHidden = false
            lastRunBgView.isHidden = false
            lastRunCloseBtn.isHidden = false
        } else {
            
            lastRunStack.isHidden = true
            lastRunBgView.isHidden = true
            lastRunCloseBtn.isHidden = true
        }
    }
    
    
    func addLastRunToMap() -> MKPolyline? {
        guard let lastRun = Run.getAllRuns()?.first else { return nil }
        
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
        
        var coordinate = [CLLocationCoordinate2D]()
        for location in lastRun.locations{
           coordinate.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            //coordinate.append(location.newLocation)
        }

        return MKPolyline(coordinates: coordinate, count: lastRun.locations.count)
    }

    //MARK: - Actions

    @IBAction func locationCenterBtnPressed(_ sender: Any) {
    }
    
    @IBAction func LastRunCloseBtnPressed(_ sender: Any) {
        lastRunStack.isHidden = true
        lastRunBgView.isHidden = true
        lastRunCloseBtn.isHidden = true
    }
}

//MARK: - CLLocationManagerDelegate

extension BeginRunVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print(#function)
        let polyLine = overlay as! MKPolyline
        // print("polyline\(polyLine)")
        let renderer = MKPolylineRenderer(polyline: polyLine)
        renderer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        renderer.lineWidth = 4
        return renderer
    }
}
