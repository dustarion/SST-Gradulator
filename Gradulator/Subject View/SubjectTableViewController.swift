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
                cell.setResultCell()
                }
                
                // Prevent the ugly selection overlay
                cell.selectionStyle = .none
                
                return cell
        }
    }

    //MARK:-
    /// TODO: Support editing and rearranging.
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
