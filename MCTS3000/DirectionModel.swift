//
//  DirectionModel.swift
//  MCTS3000
//
//  Created by Connor Henke on 5/16/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import Foundation
import ObjectMapper

struct DirectionModel: Mappable {
    var direction: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        direction <- map["dir"]
    }
}
