//
//  SubjectTableViewController.swift
//  Gradulator
//
//  Created by Dalton Ng on 7/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit

class SubjectTableViewController: UITableViewController {
    var indexPathOfSubject: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = uicolorFromHex(rgbValue: 0x434261)
        tableView.reloadData()
        
        // Set the navigation bar to show our current subject
        var subjectTitle = resultsList[indexPathOfSubject!].subject
        
        // Just for safety
        if subjectTitle == nil { subjectTitle = "Results" }
        
        self.navigationItem.title = subjectTitle
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ( 2 + resultsList[indexPathOfSubject!].results!.count )
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0: // First Cell, the graph cell
            return 184
        case 1: // Second Cell, the add button cell
            return 88
        default: // Result Cell
            return 88
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 { performSegue(withIdentifier: "toAdd", sender: self) }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0: // First Cell, the graph cell
                
                // Setup Graph Cell
                // Creating a cell using the custom class
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GraphCellTableViewCell
                
                let resultData: ResultsModel
                resultData = resultsList[indexPathOfSubject!]
                
                // Loading the data into the cell.
                cell.setGraphPoints = resultData.results
                cell.subject.text = resultData.subject
                let colors = generateGradient(indexValue: indexPathOfSubject!)
                cell.setStartColor = uicolorFromHex(rgbValue: colors[0])
                cell.setEndColor = uicolorFromHex(rgbValue: colors[1])
                
                // Append these changes to the cell
                cell.setupGraphDisplay()
                
                // Prevent the ugly selection overlay
                cell.selectionStyle = .none
            
                return cell
            case 1: // Second Cell, the add button cell
                
                // Setup Add Button Cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath)
                
                // Prevent the ugly selection overlay
                cell.selectionStyle = .none
                
                return cell
            
            default: // Result Cell
                
                // Setup Result Cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultTableViewCell
                let results = resultsList[indexPathOfSubject!].results!
                let tests = resultsList[indexPathOfSubject!].tests!
                
                // Isolate the corresponding pair
                let currentIndex = indexPath.row - 2
                print(currentIndex)
                if currentIndex <= tests.count {
                cell.setTestName = tests[currentIndex]
                cell.setPercentage = results[currentIndex]
                cell.showGrade = true
                cell.setResultCell()
                }
                
                // Prevent the ugly selection overlay
                cell.selectionStyle = .none
                
                return cell
        }
    }
}
