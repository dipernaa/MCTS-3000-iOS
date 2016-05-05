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
    var destination: String?
    var zone: String?
    var vid: String?
    var timestamp: String?
    var type: String?
    var dstp: Int?
    
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        stopId <- map["stpid"]
        stopName <- map["stpnm"]
        route <- map["rt"]
        routeDir <- map["rtdir"]
        predictionTime <- map["prdtm"]
        delay <- map["delay"]
        prediction <- map["prdctdn"]
        destination <- map["des"]
        zone <- map["zone"]
        vid <- map["vid"]
        timestamp <- map["tmstmp"]
        type <- map["typ"]
        dstp <- map["dstp"]
    }

    func isDue() -> Bool {
        return prediction == "DUE"
    }
}
