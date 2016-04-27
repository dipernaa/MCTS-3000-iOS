//
//  RouteModel.swift
//  MCTS3000
//
//  Created by Tony DiPerna on 4/21/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import Foundation
import ObjectMapper

struct RouteModel: Mappable {
    var number: String?
    var color: String?
    var name: String?
    
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        number <- map["rt"]
        color <- map["rtclr"]
        name <- map["rtnm"]
    }
}