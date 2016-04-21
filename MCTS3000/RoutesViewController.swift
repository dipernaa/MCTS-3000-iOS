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

class RoutesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRoutes()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadRoutes() {
        
        let getRoutes = GetRoutes()
        getRoutes.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else {
                return
            }
            print(object)
        }
    }

}

