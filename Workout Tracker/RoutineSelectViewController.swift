//
//  RoutineSelectViewController.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/16/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import UIKit
import CoreData

class RoutineSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet weak var routineTableView: UITableView!
    let textCellIdentifier = "RoutineCell"
    var routines: [Routine] = [Routine]()
    var date : NSDate = NSDate()
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
        routineTableView.tableFooterView = UIView(frame: CGRectZero)
        routineTableView.backgroundColor = UIColor.clearColor()
        
        // Load routine names from model
        routines = fetchRoutines()
        
        
        routineTableView.delegate = self
        routineTableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        } else {
            return routines.count + 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = routineTableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        //Configure the cell
        switch indexPath.section {
        case 0:
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            if dateFormatter.stringFromDate(date) == dateFormatter.stringFromDate(NSDate()) {
                cell.textLabel!.text = "Today"
            } else {
            cell.textLabel!.text = dateFormatter.stringFromDate(date)
            }
            dateFormatter.dateFormat = "h:mm a"
            cell.detailTextLabel!.text = dateFormatter.stringFromDate(date)
        case routines.count + 1:
            cell.textLabel!.text = "Manage Routines..."
            cell.detailTextLabel!.text = ""
        default:
            let routine = routines[indexPath.row]
            cell.textLabel!.text = routine.name
            cell.detailTextLabel!.text = routine.description
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section:    Int) -> String? {
        if section == 0 {
            return "WORKOUT DATE"
        } else {
            return "ROUTINES"
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            self.performSegueWithIdentifier("dateSegue", sender: self)
        } else {
            if indexPath.row == routines.count {
                self.performSegueWithIdentifier("manageRoutinesSegue", sender: self)
            } else {
                self.performSegueWithIdentifier("routineSelectSegue", sender: self)
            }
        }
    }
    
    func fetchRoutines() -> [Routine] {
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Routine")
        var error: NSError? = nil
        var fetchedRoutines = managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as! [Routine]
        if error != nil {
            println("An error occurred loading the data")
        }
        fetchedRoutines.sorted{$0.name < $1.name}
        return fetchedRoutines
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "routineSelectSegue") {
            let selectedIndexPath = routineTableView.indexPathForSelectedRow()
            let selectedRoutine = routines[selectedIndexPath!.row]
            if let targetView = segue.destinationViewController as? WorkoutViewController {
                    targetView.routineName = selectedRoutine.name
                    println("SELECTED: \(selectedRoutine.name)")
            } else {
                println("Destination View is not WorkoutViewController")
            }
        } else if segue.identifier == "dateSegue" {
            let targetNav = segue.destinationViewController as! UINavigationController
            let targetView = targetNav.viewControllers.first as! DateSelectViewController
            targetView.date = date
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        routineTableView.reloadData()
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
