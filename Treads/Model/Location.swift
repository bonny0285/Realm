//
//  Location.swift
//  Treads
//
//  Created by Massimiliano on 05/05/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class Location: Object {
    dynamic public private(set) var latitude = 0.0
    dynamic public private(set) var longitude = 0.0
    
    
   convenience init(latitude: Double, longitude: Double) {
    self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}
