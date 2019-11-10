//
//  RealConfig.swift
//  Treads
//
//  Created by Massimiliano on 05/05/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class RealConfig {
    static var runDataConfig: Realm.Configuration{
        let realmPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(REALM_RUN_CONFIG)
        let config = Realm.Configuration(
        fileURL: realmPath,
        schemaVersion: 0,
        migrationBlock: { migration, oldSchemaVersion in
            if  (oldSchemaVersion < 0) {
                //Nothing to do
                //Realm with automatically detect new properties and remove properties
            }
        })
        return config
    }
}
