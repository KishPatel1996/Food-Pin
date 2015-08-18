//
//  Restaurant.swift
//  FoodPin
//
//  Created by Kishan Patel on 8/13/15.
//  Copyright (c) 2015 Kishan Patel. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject {
    @NSManaged var name: String!
    @NSManaged var location: String!
    @NSManaged var type: String!
    @NSManaged var image: NSData!
    @NSManaged var isVisited: NSNumber!
    

}