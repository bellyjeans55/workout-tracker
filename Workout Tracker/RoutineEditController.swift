//
//  RoutineEditController.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/19/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import UIKit
import CoreData

class RoutineEditController: UITableViewController, UITableViewDataSource, UITableViewDelegate
{
    let routineCellID = "routineNameCell"
    let exerciseCellID = "editExerciseCell"
    var routine : Routine?
    var routineExercise : [RoutineExercise] = [RoutineExercise]()
    var set : [Set] = [Set]()
    var routineNameCell : RoutineEditCell?
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let managedContext : NSManagedObjectContext? = appDelegate.managedObjectContext {
            return managedContext
        } else {
            return nil
        }
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchExercises()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        } else {
            return routineExercise.count + 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "ROUTINE NAME"
        } else {
            return "EXERCISES"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier(indexPath), forIndexPath: indexPath) as! RoutineEditCell
        switch indexPath.section {
        case 0:
            cell.exerciseNameLabel!.text = routine!.name
            routineNameCell = cell
        case 1:
            if indexPath.row == routineExercise.count {
                cell.exerciseNameLabel!.text = "Add Exercise to Routine..."
                cell.setsRepsLabel!.text = ""
            } else {
                cell.exerciseNameLabel!.text = routineExercise[indexPath.row].exerciseName
                //cell.setsRepsLabel!.text = "\(routineExercise[indexPath.row].sets) sets × \(routineExercise[indexPath.row].reps)"
            }
        default:
            break
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == routineExercise.count {
                self.performSegueWithIdentifier("addExercise", sender: self)
            } else {
                self.performSegueWithIdentifier("editExercise", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addExercise") {
            let targetNav = segue.destinationViewController as! UINavigationController
            let targetView = targetNav.viewControllers.first as! AddExerciseController
            let routineName = routineNameCell?.routineNameField?.text
            routine?.name = routineName!
            targetView.routineExercise = routineExercise
            targetView.routine = routine
        } else if (segue.identifier == "editExercise") {
            print("go to set builder view")
        }
        //save changes segue lol
    }
    
    func cellIdentifier(indexPath: NSIndexPath) -> String {
        if indexPath.section == 0 {
            return routineCellID
        } else {
            return exerciseCellID
        }
    }
    
    func fetchExercises() {
        let fetchRequest = NSFetchRequest(entityName: "RoutineExercise")
        let sortDescriptor = NSSortDescriptor(key: "exerciseOrder", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate(format: "routineName == %@", routine!.name)
        fetchRequest.predicate = predicate
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [RoutineExercise] {
            routineExercise = fetchResults
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
