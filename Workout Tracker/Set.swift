//
//  Set.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/23/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import Foundation
import CoreData

class Set: NSManagedObject {

    @NSManaged var routineName: String
    @NSManaged var exerciseName: String
    @NSManaged var order: NSNumber
    @NSManaged var reps: NSNumber

}
