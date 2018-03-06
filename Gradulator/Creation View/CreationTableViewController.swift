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
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var testnameTextField: UITextField!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var weightageTextField: UITextField!

    // Called in viewDidLoad
    // Setup the view
    func setupCreationView() {
        self.tableView.backgroundColor = uicolorFromHex(rgbValue: 0x434261)
        // Loops the function for each of the textfields
        [subjectTextField, testnameTextField, percentageTextField, weightageTextField].forEach { (textfields) in
            // Add a 30 pt padding to the left of the textfield.
            addPaddingToTextfield(paddingAmount: 30, textfield: textfields!)
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
