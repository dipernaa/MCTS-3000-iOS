//
//  MapViewController.swift
//  MCTS3000
//
//  Created by Ryan Gahart on 5/5/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import Alamofire
import ObjectMapper

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var managedObjectContext: NSManagedObjectContext!
    var routeToLoad: RouteModel?
    var vehicles: [VehicleModel]?
    var directions: [DirectionModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let route = routeToLoad {
            print(route.name)
            loadDirections()
            loadVehicles()
        }
    }
    
    @IBAction func showStops() {
        
    }
    
    @IBAction func goToRoutes() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func loadVehicles() {
        let getPredictions = GetVehicles(withRoute: routeToLoad!.number!)
        getPredictions.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else {
                return
            }
            
            let results = object["bustime-response"]!["vehicle"]
            print(results)
            self?.vehicles = Mapper<VehicleModel>().mapArray(results)
            self!.mapView.addAnnotations((self?.vehicles)!)
        }

    }
    
    func loadDirections() {
        let getDirections = GetDirections(withRoute: routeToLoad!.number!)
        getDirections.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else {
                return
            }
            
            let results = object["bustime-response"]!["directions"]
            print(results)
            self?.directions = Mapper<DirectionModel>().mapArray(results)
        }
    }
    
    func loadStops(direction: String) {
        let getStops = GetStops(withRoute: routeToLoad!.number!, direction: direction)
        getStops.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else {
                return
            }
            
            let results = object["bustime-response"]!["stops"]
            print(results)
//            self?.stops = Mapper<StopModel>().mapArray(results)
        }

    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "Location"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as MKAnnotationView!
        
        
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            if let vehicleView = annotation as? VehicleModel {
                var image = UIImage(named: "arrow")
            
                image = image?.imageRotatedByDegrees(CGFloat(Int(vehicleView.heading!)!), flip: false)
                annotationView.enabled = true
                annotationView.image = image
                annotationView.frame.size = CGSize(width: 20.0, height: 20.0)
            }
            
        } else {
            annotationView.annotation = annotation
        }
        return annotationView
    }
}

extension MapViewController: UINavigationBarDelegate {
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
}