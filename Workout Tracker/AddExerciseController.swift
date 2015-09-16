//
//  AddExerciseController.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/20/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import UIKit
import CoreData

class AddExerciseController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var exercises : [Exercise] = [Exercise]()
    var routine : Routine?
    var routineExercise : [RoutineExercise] = [RoutineExercise]()
    let cellIdentifier = "exerciseCell"
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let managedContext : NSManagedObjectContext = appDelegate.managedObjectContext {
            return managedContext
        } else {
            return nil
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        exercises = fetchExercises()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return exercises.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "EXERCISES"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = "\(exercises[indexPath.row].name)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("addExerciseToRoutine", sender: self.exercises[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "addExerciseToRoutine") {
            let targetView = segue.destinationViewController as! RoutineEditController
            let routineExerciseObject = NSEntityDescription.insertNewObjectForEntityForName("RoutineExercise", inManagedObjectContext: self.managedObjectContext!) as? RoutineExercise
            targetView.routine = routine
            routineExerciseObject?.exerciseName = (sender as? Exercise)!.name
            routineExerciseObject?.exerciseOrder = targetView.routineExercise.count
            routineExerciseObject?.routineName = targetView.routine!.name
            routineExercise.append(routineExerciseObject!)
            targetView.routineExercise = routineExercise
        }
    }
    
    func createSet(exercise:Exercise) -> Set {
        let set = NSEntityDescription.insertNewObjectForEntityForName("Set", inManagedObjectContext: self.managedObjectContext!) as! Set
        set.routineName = routine!.name
        set.exerciseName = exercise.name
        set.reps = 0
        return set
    }
    
    func fetchExercises() -> [Exercise] {
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Exercise")
        var error: NSError? = nil
        var fetchedExercises = managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as! [Exercise]
        if error != nil {
            println("An error occurred loading the data")
        }
        return fetchedExercises.sorted{$0.name < $1.name}
    }
    
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            
            // Create an `NSCharacterSet` set which includes everything *but* the digits
            let inverseSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
            
            // At every character in this "inverseSet" contained in the string,
            // split the string up into components which exclude the characters
            // in this inverse set
            let components = string.componentsSeparatedByCharactersInSet(inverseSet)
            
            // Rejoin these components
            let filtered = join("", components)
            
            // If the original string is equal to the filtered string, i.e. if no
            // inverse characters were present to be eliminated, the input is valid
            // and the statement returns true; else it returns false
            return string == filtered
            
    }

}
