//
//  Run.swift
//  Treads
//
//  Created by Massimiliano on 30/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import RealmSwift

class Run: Object {
    @objc dynamic  var id = ""
    @objc dynamic  var date = NSDate()
    @objc dynamic  var pace = 0
    @objc dynamic  var distance = 0.0
    @objc dynamic  var duration = 0
    dynamic var locations = List<Location>()
   // @objc dynamic var lacations = [Location]()
    
    
    
    
    override static func primaryKey() -> String? {
        print(#function)
        return "id"
    }
    
    
    override static func indexedProperties() -> [String] {
        print(#function)
        return ["pace", "date", "duration"]
    }
    
    convenience init(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
    
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        self.locations = locations
        print(id, date, pace, distance, duration)
    }
    
    static func addRUnToReal(pace: Int, distance: Double, duration: Int, locations : List<Location>){
    
        print("addRunToReal \(locations)")
        
        REALM_QUEUE.sync {
            
            let run = Run(pace: pace, distance: distance, duration: duration, locations: locations)
            
            do {
                let realm = try Realm(configuration: RealConfig.runDataConfig)
                try! realm.write {
                    realm.add(run)
                    print("RUN \(run)")
                    try! realm.commitWrite()
                }
            } catch {
                debugPrint("Error adding run to Realm")
            }
        }
    }
    
    
    
    static func getAllRuns() -> Results<Run>? {
        print(#function)
        do {
            let realm = try Realm(configuration: RealConfig.runDataConfig)
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)
            print("dati in tabella   \(runs)")
            return runs
        } catch {
            return nil
        }
    }
}
