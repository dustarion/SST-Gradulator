//
//  ResultTableViewCell.swift
//  Gradulator
//
//  Created by Dalton Ng on 7/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    // Formatted as such purely for readibility reasons.
    
    var setTestName: String?
    var setPercentage: Int?
    var showGrade: Bool?
    
    @IBOutlet weak var TestLabel: UILabel!
    @IBOutlet weak var PercentageLabel: UILabel!
    
    /// Using the variables setTestName and setPercentage, append these values to the approriate labels.
    func setResultCell() {
        
        // Just a quick check for nil values for safety reasons
        if setTestName == nil { setTestName = "Test" }
        if showGrade == nil { showGrade = false }
        
        // Set the test name
        TestLabel.text = setTestName
        
        // Set the percentage Label
        if showGrade! { PercentageLabel.text = returnGrade(ofPercentage: setPercentage!) }
        else { PercentageLabel.text = ((setPercentage?.description)! + "%") }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
