//
//  Stop+CoreDataProperties.swift
//  MCTS3000
//
//  Created by Tony DiPerna on 4/28/16.
//  Copyright © 2016 MSOE SE-4910i. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Stop {

    @NSManaged var stopId: String
    @NSManaged var stopName: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double

}
