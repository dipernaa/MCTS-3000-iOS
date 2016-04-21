//
//  SecondViewController.swift
//  MCTS3000
//
//  Created by Tony DiPerna on 4/20/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class RoutesViewController: UITableViewController {
    
    var routes: [RouteModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRoutes()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("RouteCell", forIndexPath: indexPath) as? RouteCell else {
            fatalError("THIS SHOULD NEVER HAPPEN")
        }
        
        let route = routes?[indexPath.row]
        
        cell.lblTitle.text = route?.number ?? "no route number"
        return cell
    }

    func loadRoutes() {
        
        let getRoutes = GetRoutes()
        getRoutes.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else {
                return
            }
            
            let results = object["bustime-response"]
            let acutalResults = results!["routes"]
            self?.routes = Mapper<RouteModel>().mapArray(acutalResults)
            print(acutalResults)
        }
    }

}

