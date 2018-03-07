//
//  CreationTableViewController.swift
//  Gradulator
//
//  Created by Dalton Ng on 5/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit
import SCLAlertView
import DeviceKit

class CreationTableViewController: UITableViewController {
    
    // Define our textfield Outlets
    @IBOutlet weak var subjectTextField: SearchTextField!
    @IBOutlet weak var testnameTextField: SearchTextField!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var weightageTextField: UITextField!
    
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
        testnameTextField.filterStrings(testsList)
        [subjectTextField, testnameTextField].forEach { (textfields) in
            
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
    func saveResult() {
        let subject = subjectTextField.text
        let testname = testnameTextField.text
        var percentage = (percentageTextField.text! as NSString).integerValue
        let weightage = (weightageTextField.text! as NSString).doubleValue
        
        // First Check for Nil Values, percentage and weightage will automatically become 0 if left empty due to the nature of .integerValue and .doubleValue
        illegalCheck: if (subject != "") {
            guard (testname
                != "") else { SCLAlertView().showWarning("Some fields are empty!", subTitle: "Check if you forgot to fill up any info.") ; break illegalCheck }
        // No Fields are nil, checking for illegal values...
            
            // Subject
            if !(subjectList.contains(subject!)) {
                // New Subject, check for character limit of 10.
            guard subject!.count <= 10 else {
                SCLAlertView().showWarning("Subject has too many characters", subTitle: "Sorry, there is a character limit of 10 for the subject name. Consider using a shorter version of the name?")
                break illegalCheck }
                    // 10 or less characters, safe to continue
                saveNewSubjectToDisk(subject: subject!)
            }
            
            // Testname
            if !(testsList.contains(testname!)) {
                // New Test, check for character limit of 10.
            guard testname!.count <= 10 else {
                SCLAlertView().showWarning("Test has too many characters", subTitle: "Sorry, there is a character limit of 10 for the test name. Consider using a shorter version of the name?")
                break illegalCheck }
                    // 10 or less characters, safe to continue
                saveNewTestToDisk(test: testname!)
            }
            
            // Percentage must be between 0...100
            if percentage > 100 {
                percentage = 100
            }
            if percentage < 0 {
                percentage = 0
            }
            
            // Weightage
            guard !(weightage > returnRemainingWeightage(ofSubject: subject!)) else {
                SCLAlertView().showWarning("Result Weightage Exceeds 100%", subTitle: "Your total weightage exceeds 100%, we've set the weightage to the maximum possible value for you.")
                weightageTextField.text = String(returnRemainingWeightage(ofSubject: subject!))
                break illegalCheck }
            
            // Since all values are fine or have been corrected, continue with saving result
            print("Saving Result : ", subject ?? "nil", testname ?? "nil", percentage, weightage)
            
            // Calculate Grade
            let grade = returnGrade(ofPercentage: percentage)
            
            // Could be greater than 100 or a negative, handle this!
            var markToScoreNext = returnScoreNextTest(underSubject: subject!, percentage: percentage, weightage: weightage)
            
            // TODO: Handle these 2 situations better.
            if markToScoreNext > 100 { markToScoreNext = 100 }
            if markToScoreNext < 0 { markToScoreNext = 0 }
            
            print(grade, markToScoreNext)
            // Save Grade to disc
            saveNewResultToDisk(ofSubject: subject!, withTestname: testname!, withResult: percentage, withWeightage: weightage)
        
            // Show a popup to the user so they know their results.
            showResultPopup(grade: grade, nextTestScore: String(markToScoreNext))
        }
        // Nil Field Somewhere
        // TODO: Determine exactly which field is nil
        else {
            print("Nil Values Detected")
            // Show popup that fields are nil
            SCLAlertView().showWarning("Some fields are empty!", subTitle: "Check if you forgot to fill up any info.")
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
    }
        
    fileprivate func showResultPopup(grade: String, nextTestScore: String) {
            print("Show Result Popup")
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            // Initialize SCLAlertView using custom Appearance
            let alert = SCLAlertView(appearance: appearance)
            alert.addButton("Done") {
                print("Escaping to the main view")
                self.dismiss(animated: true, completion: nil)
            }
        
            // Show the popup
            alert.showInfo("Results", subTitle: "Your grade is \(grade)! Score \(nextTestScore)% on your next test to hit your goal.")
    }
    
    // TODO: Find a better solution
    // On Iphone SE this brings the textfield above the keyboard.
    // Behaves weirdly above 4 inch screens.
    // Using a workaround first.
    @IBAction func weightageEditingDidBegin(_ sender: Any) {
        let groupOfAllowedDevices: [Device] = [.iPhoneSE, .iPhone5s, .iPhone5, .simulator(.iPhoneSE), .simulator(.iPhone5s), .simulator(.iPhone5)]
        let device = Device()
        if device.isOneOf(groupOfAllowedDevices) {
            let pointInTable:CGPoint = weightageTextField.superview!.convert(weightageTextField.frame.origin, to:tableView)
            var contentOffset:CGPoint = tableView.contentOffset
            contentOffset.y  = pointInTable.y
            if let accessoryView = weightageTextField.inputAccessoryView {
                contentOffset.y -= accessoryView.frame.size.height
            }
            tableView.contentOffset = contentOffset
        }
    }
}
