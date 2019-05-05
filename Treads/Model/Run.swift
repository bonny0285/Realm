//
//  Run.swift
//  Treads
//
//  Created by Massimiliano on 30/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import Foundation
import RealmSwift

class Run: Object {
    @objc dynamic  var id = ""
    @objc dynamic  var date = NSDate()
    @objc dynamic  var pace = 0
    @objc dynamic  var distance = 0.0
    @objc dynamic  var duration = 0
    dynamic  var locations = List<Location>()
    
    
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
        print(#function)
        
        REALM_QUEUE.sync {
            let config = Realm.Configuration(
                // Set the new schema version. This must be greater than the previously used
                // version (if you've never set a schema version before, the version is 0).
                schemaVersion: 1,
                
                // Set the block which will be called automatically when opening a Realm with
                // a schema version lower than the one set above
                migrationBlock: { migration, oldSchemaVersion in
                    // We haven’t migrated anything yet, so oldSchemaVersion == 0
                    if (oldSchemaVersion < 1) {
                        // Nothing to do!
                        // Realm will automatically detect new properties and removed properties
                        // And will update the schema on disk automatically
                    }
            })
            
            // Tell Realm to use this new configuration object for the default Realm
            Realm.Configuration.defaultConfiguration = config
            print("config\(config)")
            print("configurazione \(Realm.Configuration.defaultConfiguration)")
            let run = Run(pace: pace, distance: distance, duration: duration, locations: locations)
            print("Run \(run)")
            let realm = try! Realm()
            try! realm.write {
                realm.add(run, update: true)
            }
        }
        
    }
    
    
    
    static func getAllRuns() -> Results<Run>? {
        print(#function)
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
         let realm = try! Realm()
         var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)
            //print("dati in tabella   \(runs)")
            return runs
    }
    
    
}
