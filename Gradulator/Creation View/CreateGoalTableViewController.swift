//
//  CreateGoalTableViewController.swift
//  Gradulator
//
//  Created by Dalton Ng on 8/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit
import SCLAlertView

class CreateGoalTableViewController: UITableViewController {
    
    // Define our textfield Outlets
    @IBOutlet weak var subjectTextField: SearchTextField!
    @IBOutlet weak var targetTextField: SearchTextField!
    var gradesList = ["A1", "A2", "B3", "B4", "C5", "C6", "D7"] //Not allowed to set a goal below a pass.
    
    // Called in viewDidLoad
    /// Setup the view
    fileprivate func setupCreationView() {
        self.tableView.backgroundColor = uicolorFromHex(rgbValue: 0x434261)
        // Loops the function for each of the textfields
        [subjectTextField, targetTextField].forEach { (textfields) in
            // Add a 30 pt padding to the left of the textfield.
            addPaddingToTextfield(paddingAmount: 30, textfield: textfields)
        }
        
        // Add search capabilities to Subject Field and Testname Field
        subjectTextField.filterStrings(subjectList)
        targetTextField.filterStrings(gradesList)
        [subjectTextField, targetTextField].forEach { (textfields) in
            
            // Modify current theme properties
            textfields?.theme.font = UIFont.systemFont(ofSize: 14.0)
            textfields?.theme.bgColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            textfields?.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            textfields?.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
            textfields?.theme.cellHeight = 40
            
            // When showing autocomplete suggestions
            textfields?.highlightAttributes = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14.0)]
        }
    }
    
    // Called upon clicking the 'Done' button
    /// Process the data and save to disk.
    func saveTarget() {
        let subject = subjectTextField.text
        let goal = targetTextField.text
        var Intgoal = Int(goal!)
        
        // First Check for Nil Values, percentage and weightage will automatically become 0 if left empty due to the nature of .integerValue and .doubleValue
        illegalCheck: if (subject != "") {
            guard goal != "" else { SCLAlertView().showWarning("Some fields are empty!", subTitle: "Check if you forgot to fill up any info.") ; break illegalCheck }
            // No Fields are nil, checking for illegal values...
            
            // We cannot allow them to save a goal if the subject does not exist.
            guard doesSubjectExist(ofSubject: subject!) else { SCLAlertView().showWarning("Subject not found", subTitle: "You can only add a goal for subjects that have results already. Add a new result first.") ; break illegalCheck }
            
            // Goal
            // First we need to determine if its a percentage or if its a grade such as A1
            if Intgoal != nil {
                //Valid Percentage as Int
                if Intgoal! > 100 { Intgoal! = 100 }
                if Intgoal! < 50 { Intgoal! = 50 }
                saveNewGoalToDisk(ofSubject: subject!, ofGoal: Int(goal!)!)
                // Dismiss ViewController
                dismiss(animated: true, completion: nil)
            } else {
                // Not a percentage, determine if its an allowed grade format.
                guard gradesList.contains(goal!.uppercased()) else {
                    SCLAlertView().showWarning("Unknown Grade", subTitle: "Sorry, we are unable to process the grade you entered. Please use a standard grade such as A1")
                    break illegalCheck }
                // Its a valid grade
                saveNewGoalToDisk(ofSubject: subject!, ofGoal: returnPercentage(ofGrade: goal!))
                // Dismiss ViewController
                dismiss(animated: true, completion: nil)
            }
        }
            
        // Nil Field Somewhere
        // TODO: Determine exactly which field is nil
        else {  print("Nil Values Detected")
                SCLAlertView().showWarning("Some fields are empty!", subTitle: "Check if you forgot to fill up any info.") }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCreationView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        saveTarget()
    }
}
