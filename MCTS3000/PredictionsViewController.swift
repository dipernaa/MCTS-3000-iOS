//
//  PredictionsViewController.swift
//  MCTS3000
//
//  Created by Connor Henke on 4/28/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//

import UIKit
import ObjectMapper

class PredictionsViewController: UITableViewController {
    
    var predictions: [PredictionModel]?
    var stopId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPredictions()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveFavorite() {
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("PredictionCell", forIndexPath: indexPath) as? PredictionCell else {
            fatalError("THIS SHOULD NEVER HAPPEN")
        }
        
        let prediction = predictions?[indexPath.row]
        
        cell.routeNumber.text = prediction?.route
        cell.routeDirection.text = prediction?.routeDir
        
        var text: String
        if (prediction?.delay == true) {
            text = "Delayed"
        } else if (prediction?.isDue() == true) {
            text = "Due"
        } else {
            text = (prediction?.prediction)! + " minutes"
        }
        cell.prediction.text = text
        
        return cell
    }

    
    func loadPredictions() {
        let getPredictions = GetPredictions(withStopId: "5132")
        getPredictions.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else {
                return
            }
            
            let results = object["bustime-response"]!["prd"]
            print(results)
            self?.predictions = Mapper<PredictionModel>().mapArray(results)
            self?.tableView.reloadData()
        }

    }

}
