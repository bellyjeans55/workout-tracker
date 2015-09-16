//
//  RoutineExercise.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/23/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import Foundation
import CoreData

class RoutineExercise: NSManagedObject {

    @NSManaged var exerciseName: String
    @NSManaged var exerciseOrder: NSNumber
    @NSManaged var routineName: String

}
