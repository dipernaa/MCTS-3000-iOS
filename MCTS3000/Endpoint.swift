//
//  Endpoint.swift
//  MCTS3000
//
//  Created by Tony DiPerna on 4/21/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import Foundation
import Alamofire

private let API_KEY = "wHRcbttmWX6FFh9t25u8Ea6K9"
private let API = "http://realtime.ridemcts.com/bustime/api/v2/"
private let BASE_PARAMS: [String: AnyObject]? = ["key": API_KEY, "format": "json"]
private let GOOGLE_DIRECTIONS = "maps.google.com/maps/api/directions/json"

private let ROUTES_ENDPOINT = "getroutes"
private let ROUTES_OBJECT = "routes"

private let VEHICLES_ENDPOINT = "getvehicles"
private let VEHICLES_OBJECT = "vehicle"

private let STOPS_ENDPOINT = "getstops"
private let STOPS_OBJECT = "stops"

private let DIRECTIONS_ENDPOINT = "getdirections"
private let DIRECTIONS_OBJECT = "directions"

private let PREDICTIONS_ENDPOINT = "getpredictions"
private let PREDICTIONS_OBJECT = "prd"

protocol Endpoint {
    var method: Alamofire.Method { get }
    var endpoint: String { get }
    var params: [String: AnyObject]? { get }
}

extension Endpoint {
    func request(handler: (object: AnyObject?) -> ()) {
        //API + endpoint + "?key=" + API_KEY + "&format=json" + params
        Alamofire.request(method, "\(API)\(endpoint)", parameters: params).responseJSON { (response) -> Void in
            handler(object: response.result.value)
        }
    }
}


class GetRoutes: Endpoint {
    var method = Alamofire.Method.GET
    var endpoint = ROUTES_ENDPOINT
    var params = BASE_PARAMS
}

class GetVehicles: Endpoint {
    var method = Alamofire.Method.GET
    var endpoint = VEHICLES_ENDPOINT
    var params = BASE_PARAMS

    init(withRoute route: String) {
        params!["rt"] = route
    }
}