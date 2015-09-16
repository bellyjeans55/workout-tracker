//
//  DateSelectViewController.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/16/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import UIKit

class DateSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let textCellIdentifier = "DateDisplayCell"
    var date = NSDate()
    @IBOutlet weak var dateDisplayTable: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.date = date
        datePicker.addTarget(self, action: "datePickerValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        dateDisplayTable.tableFooterView = UIView(frame: CGRectZero)
        dateDisplayTable.backgroundColor = UIColor.clearColor()
        dateDisplayTable.scrollEnabled = false
        
        // Do any additional setup after loading the view.
        dateDisplayTable.delegate = self
        dateDisplayTable.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = dateDisplayTable.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        if (indexPath.row == 0) {
            let currentDateString = datePickerString(datePicker.date, formatString:"EEEE, MMM d, yyyy")
            if currentDateString == datePickerString(NSDate(), formatString:"EEEE, MMM d, yyyy"){
                cell.textLabel!.text = "Today"
            } else {
                cell.textLabel!.text = currentDateString
            }
            cell.detailTextLabel!.text = datePickerString(datePicker.date, formatString:"h:mm a")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        } else {
            cell.textLabel!.text = "Reset to Current Date"
            cell.detailTextLabel!.text = ""
            cell.textLabel?.font = UIFont.systemFontOfSize(14)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            dateResetPressed()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "doneDatePickSegue") {
            let target = segue.destinationViewController as! RoutineSelectViewController
            target.date = datePicker.date
        }
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        dateDisplayTable.reloadData()
    }
    
    func dateResetPressed() {
        datePicker.date = NSDate()
        dateDisplayTable.reloadData()
    }
    
    func datePickerString(date:NSDate, formatString:String) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = formatString
        return dateFormatter.stringFromDate(date)
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
