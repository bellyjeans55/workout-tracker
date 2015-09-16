//
//  Routine.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/19/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import Foundation
import CoreData

class Routine: NSManagedObject {

    @NSManaged var name: String
    
//    convenience init(name: String, entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
//        self.init(entity: entity, insertIntoManagedObjectContext: context)
//        self.name = name
//    }
}
