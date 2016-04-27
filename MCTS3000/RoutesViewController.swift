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
        
        cell.lblColor.backgroundColor = hexStringToUIColor((route?.color)!) ?? UIColor.clearColor()
        cell.lblNumber.text = route?.number ?? "no route number"
        cell.lblName.text = route?.name ?? "no route name"
        return cell
    }

    func loadRoutes() {
        let getRoutes = GetRoutes()
        getRoutes.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else {
                return
            }
            
            let results = object["bustime-response"]!["routes"]
            self?.routes = Mapper<RouteModel>().mapArray(results)
            self?.tableView.reloadData()
            
        }
    }

    func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

