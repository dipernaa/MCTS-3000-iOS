//
//  VehicleModel.swift
//  MCTS3000
//
//  Created by Connor Henke on 5/11/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import Foundation
import ObjectMapper
import MapKit

class VehicleModel: NSObject, Mappable, MKAnnotation {
    var lat: String?
    var lon: String?
    var heading: Int?
    var vid: Int?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lon <- map["lon"]
        heading <- map["hdg"]
        vid <- map["vid"]
    }
    
    @objc var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(Double(lat!)!, Double(lon!)!)
    }
    
    @objc var title: String? {
        return String(vid)
    }
}