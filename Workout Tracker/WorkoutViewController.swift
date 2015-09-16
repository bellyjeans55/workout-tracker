//
//  WorkoutViewController.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/16/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import UIKit
import CoreData

class WorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var workoutTable: UITableView!
    let cellIdentifier = "exerciseCell"
    var routineName : String? = nil
    var exercises : [Exercise] = [Exercise]()
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
        // Do any additional setup after loading the view.
        
        
        workoutTable.dataSource = self
        workoutTable.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0 {
            return exercises.count
        } else {
            return 2 //notes and bodyweight
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Configure the cell
        
        let cell = workoutTable.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WorkoutViewCell
        switch indexPath.section {
        case 0:
            break
//            var exerciseSetsAndRepsTuple = sampleData.routineData[0].exercises[indexPath.row]
//            var completedSets = 0 //TODO: get this info from the coredata model
//            cell.exerciseNameLabel!.text = exerciseSetsAndRepsTuple.0.name
//            cell.setsRepsLabel!.text = "\(completedSets)/\(exerciseSetsAndRepsTuple.1.0) sets"
        case 1:
            switch indexPath.row {
            case 0:
                cell.exerciseNameLabel!.text = "Notes"
                cell.setsRepsLabel.text = ""
            case 1:
                var bodyweight = 203 //TODO: get this info from the coredata model
                cell.exerciseNameLabel!.text = "Bodyweight"
                cell.setsRepsLabel.text = "\(bodyweight) lbs"
            default:
                break
            }
        default:
            break
        }
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section:    Int) -> String? {
        if section == 0 {
            return "EXERCISES"
        } else {
            return "NOTES"
        }
    }
    
    func fetchExerciseData() {
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "RoutineExercise")
        var error: NSError? = nil
        var fetchedExercise = managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as! [Exercise]
        if error != nil {
            println("An error occurred loading the data")
        }
        //fetchedExercise.sorted{$0.exerciseOrder < $1.exerciseOrder}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
