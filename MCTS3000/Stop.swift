//
//  Stop.swift
//  MCTS3000
//
//  Created by Tony DiPerna on 5/11/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import MapKit
import Realm

class Stop: Object, Mappable, MKAnnotation {
    
    dynamic var stopId = ""
    dynamic var stopName = ""
    dynamic var lat: Double = 0.0
    dynamic var lon: Double = 0.0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lon <- map["lon"]
        stopId <- map["stpid"]
        stopName <- map["stpnm"]
    }
    
    @objc var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(lat, lon)
    }
    
    @objc var title: String? {
        return stopId
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
