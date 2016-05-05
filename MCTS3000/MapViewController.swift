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

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var managedObjectContext: NSManagedObjectContext!

    
    @IBAction func showStops() {
        
    }
    
    @IBAction func refresh() {
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    @IBAction func goToRoutes() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension MapViewController: MKMapViewDelegate {
    
}