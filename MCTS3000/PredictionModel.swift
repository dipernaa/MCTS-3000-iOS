//
//  PredictionModel.swift
//  MCTS3000
//
//  Created by Connor Henke on 4/28/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import Foundation
import ObjectMapper

struct PredictionModel: Mappable {
    var stopId: String?
    var stopName: String?
    var route: String?
    var routeDir: String?
    var predictionTime: String?
    var delay: Bool?
    var prediction: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        stopId: String?
        stopName: String?
        route: String?
        routeDir: String?
        predictionTime: String?
        delay: Bool?
        prediction: String?
        number <- map["rt"]
        color <- map["rtclr"]
        name <- map["rtnm"]
    }
}
