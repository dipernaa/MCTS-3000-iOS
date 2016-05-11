//
//  FirstViewController.swift
//  MCTS3000
//
//  Created by Tony DiPerna on 4/20/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesViewController: UITableViewController {
    
    let realm = try! Realm()
    lazy var stops: Results<Stop> = { self.realm.objects(Stop) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("StopCell", forIndexPath: indexPath) as? StopCell else {
            fatalError("THIS SHOULD NEVER HAPPEN")
        }
        
        let stop = stops[indexPath.row]
        print("\(stop.stopName)")
        cell.lblName.text = stop.stopName
        return cell
    }
}

