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
    
    
    var stops: Results<Stop>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStops()
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
        return stops?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("StopCell", forIndexPath: indexPath) as? StopCell else {
            fatalError("THIS SHOULD NEVER HAPPEN")
        }
        
        let stop = stops?[indexPath.row]
        cell.lblName.text = stop?.stopName
        return cell
    }
    
    func loadStops() {
        let realm = try! Realm()
        stops = { realm.objects(Stop) }()
        tableView.reloadData()
    }
}

