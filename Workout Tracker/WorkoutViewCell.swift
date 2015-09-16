//
//  WorkoutViewCell.swift
//  Weight Tracker
//
//  Created by Jonathan Kay on 7/16/15.
//  Copyright (c) 2015 Jonathan Kay. All rights reserved.
//

import UIKit

class WorkoutViewCell: UITableViewCell {

    @IBOutlet weak var setsRepsLabel: UILabel!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
