//
//  CreationTableViewController.swift
//  Gradulator
//
//  Created by Dalton Ng on 5/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit

class CreationTableViewController: UITableViewController {
    
    // Define our textfield Outlets
    @IBOutlet weak var subjectTextField: SearchTextField!
    @IBOutlet weak var testnameTextField: SearchTextField!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var weightageTextField: UITextField!
    
    var subjectList = ["English","Physics","Chemistry", "Biology"]
    var testList = ["CA1","CA2","SA1", "SA2"]

     // Called in viewDidLoad
    /// Setup the view
    fileprivate func setupCreationView() {
        self.tableView.backgroundColor = uicolorFromHex(rgbValue: 0x434261)
        // Loops the function for each of the textfields
        [subjectTextField, testnameTextField, percentageTextField, weightageTextField].forEach { (textfields) in
            // Add a 30 pt padding to the left of the textfield.
            addPaddingToTextfield(paddingAmount: 30, textfield: textfields!)
        }
        
        // Add search capabilities to Subject Field and Testname Field
        subjectTextField.filterStrings(subjectList)
        testnameTextField.filterStrings(testList)
        [subjectTextField, testnameTextField].forEach { (textfields) in
            
            // Modify current theme properties
            textfields?.theme.font = UIFont.systemFont(ofSize: 14.0)
            textfields?.theme.bgColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.9)
            textfields?.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            textfields?.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
            textfields?.theme.cellHeight = 40
            
            // When showing autocomplete suggestions
            textfields?.highlightAttributes = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14.0)]
        }
    }
    
     // Called upon clicking the 'Done' button
    /// Process the data and save to disk.
    func saveResult() {
        let subject = subjectTextField.text
        let testname = testnameTextField.text
        var percentage = (percentageTextField.text! as NSString).integerValue
        var weightage = (weightageTextField.text! as NSString).doubleValue
        
        // First Check for Nil Values, percentage and weightage will automatically become 0 if left empty due to the nature of .integerValue and .doubleValue
        illegalCheck: if !((subject == nil) && (testname == nil)) {
        // No Fields are nil, checking for illegal values...
            
            // Subject
            guard !(subjectList.contains(subject!)) else { break illegalCheck }
                // New Subject, check for character limit of 10.
            guard subject!.count <= 10 else { break illegalCheck }
                    // 10 or less characters, safe to continue
                    // TODO: Save to stored array of subjects
            
            // Testname
            guard !(testList.contains(testname!)) else { break illegalCheck }
                // New Test, check for character limit of 10.
            guard testname!.count <= 10 else { break illegalCheck }
                    // 10 or less characters, safe to continue
                    // TODO: Save to stored array of tests
            
            // Percentage must be between 0...100
            if percentage > 100 {
                percentage = 100
            }
            if percentage < 0 {
                percentage = 0
            }
            
            // Weightage
            guard !(weightage > returnRemainingWeightage(ofSubject: subject!)) else { break illegalCheck }
            
            // Since all values are fine or have been corrected, continue with saving result
            print("Saving Result : ", subject ?? "nil", testname ?? "nil", percentage, weightage)
            
            // Calculate Grade
            let grade = returnGrade(ofPercentage: percentage)
            
            // Could be greater than 100 or a negative, handle this!
            let markToScoreNext = returnScoreNextTest(underSubject: subject!, percentage: percentage, weightage: weightage)
            
            print(grade, markToScoreNext)
            // Save Grade
        }
        
        // Nil Field Somewhere
        // TODO: Determine exactly which field is nil
        else {
            print("Nil Values Detected")
            // Show popup that fields are nil
        }
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
        saveResult()
        //dismiss(animated: true, completion: nil)
    }
    
    /*
    /// TODO: Find a better solution
    // On Iphone SE this brings the textfield above the keyboard.
    // Crashes above iphone SE, do not uncomment
    @IBAction func weightageEditingDidBegin(_ sender: Any) {
        let pointInTable:CGPoint = weightageTextField.superview!.convert(weightageTextField.frame.origin, to:tableView)
        var contentOffset:CGPoint = tableView.contentOffset
        contentOffset.y  = pointInTable.y
        if let accessoryView = weightageTextField.inputAccessoryView {
            contentOffset.y -= accessoryView.frame.size.height
        }
        tableView.contentOffset = contentOffset
    }*/
    
}
