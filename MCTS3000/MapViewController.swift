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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let route = routeToLoad {
            print(route.name)
            loadVehicles()
        }
    }
    
    @IBAction func showStops() {
        
    }
    
    @IBAction func refresh() {
        mapView.delegate = self
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
    }
    
    @IBAction func goToRoutes() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadVehicles() {
        
        let getPredictions = GetVehicles(withRoute: routeToLoad!.number!)
        getPredictions.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else {
                return
            }
            
            let results = object["bustime-response"]!["vehicle"]
            self?.vehicles = Mapper<VehicleModel>().mapArray(results)
            self!.mapView.addAnnotations((self?.vehicles)!)
        }

    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "Location"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as MKAnnotationView!
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView.enabled = true
            annotationView.image = UIImage(named: "arrow")
            
//            let rightButton = UIButton(type: .DetailDisclosure)
//            rightButton.addTarget(self, action: Selector("showLocationDetails:"), forControlEvents: .TouchUpInside)
//            annotationView.rightCalloutAccessoryView = rightButton
        } else {
            annotationView.annotation = annotation
        }
        
//        let button = annotationView.rightCalloutAccessoryView as! UIButton
//        if let index = locations.indexOf(annotation as! Location) {
//            button.tag = index
//        }
        
        return annotationView
    }
}

extension MapViewController: UINavigationBarDelegate {
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
}