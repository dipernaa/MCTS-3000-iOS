//
//  Stop.swift
//  MCTS3000
//
//  Created by Tony DiPerna on 5/11/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import Foundation
import RealmSwift

class Stop: Object {
    
    dynamic var stopId = "";
    dynamic var stopName = "";
    dynamic var latitude: Double = 0.0;
    dynamic var longitude: Double = 0.0;
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
