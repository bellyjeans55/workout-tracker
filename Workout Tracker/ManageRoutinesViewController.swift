//
//  ManageRoutinesViewController.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/19/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import UIKit
import CoreData

class ManageRoutinesViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate
{

    let textCellIdentifier = "RoutineCell"
    var routines: [Routine] = [Routine]()
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
        tableView.tableFooterView = UIView(frame: CGRectZero)

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
        return routines.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        if indexPath.row == routines.count {
            cell.textLabel!.text = "Add New Routine..."
            cell.detailTextLabel!.text = ""
            cell.accessoryType = UITableViewCellAccessoryType.None
        } else {
            let routine = routines[indexPath.row]
            cell.textLabel!.text = routine.name
            cell.detailTextLabel!.text = routine.description
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section:    Int) -> String? {
        return "ROUTINES"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == routines.count {
            self.performSegueWithIdentifier("addRoutine", sender: self)
        } else {
            self.performSegueWithIdentifier("editRoutine", sender: self)
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
        
        if (segue.identifier == "editRoutine") {
            let targetNav = segue.destinationViewController as! UINavigationController
            let targetView = targetNav.viewControllers.first as! RoutineEditController
            let selectedIndexPath = tableView.indexPathForSelectedRow()
            let selectedRoutine = routines[selectedIndexPath!.row]
            targetView.routine = selectedRoutine
        } else if (segue.identifier == "addRoutine") {
            let targetNav = segue.destinationViewController as! UINavigationController
            let targetView = targetNav.viewControllers.first as! RoutineEditController
            targetView.routine = NSEntityDescription.insertNewObjectForEntityForName("Routine", inManagedObjectContext: self.managedObjectContext!) as? Routine
            targetView.routine?.name = ""
        }
    }

}
