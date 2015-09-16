//
//  Workout.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/19/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import Foundation
import CoreData

class Workout: NSManagedObject {

    @NSManaged var bodyweight: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var routineName: String

}
