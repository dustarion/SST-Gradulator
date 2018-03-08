//
//  TableViewController.swift
//  Gradulator
//
//  Created by Dalton Ng on 1/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit
import Disk
import SCLAlertView

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = uicolorFromHex(rgbValue: 0x434261)
        
        // Obtaining our saved results object from memory
        do{
        let retrievedResultsList = try Disk.retrieve("Gradulator/Results.json", from: .documents, as: [ResultsModel].self)
        print(retrievedResultsList)
        resultsList = retrievedResultsList
        print (resultsList)
        
        // Reload the tableview now that we have new data. It should be able to load correctly now.
        tableView.reloadData()
        
        }
        
        catch {
            print(error.localizedDescription)
        }
        loadFromDisk()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GraphCellTableViewCell
        
        let resultData: ResultsModel
        resultData = resultsList[indexPath.row]
        
        // Loading the data into the cell.
        //if resultData.results == nil { return cell }
        cell.setGraphPoints = resultData.results
        cell.subject.text = resultData.subject
        
        // Alternate the colours of the graph
        let colors = generateGradient(indexValue: indexPath.row)
        cell.setStartColor = uicolorFromHex(rgbValue: colors[0])
        cell.setEndColor = uicolorFromHex(rgbValue: colors[1])
        
        // Append these changes to the cell
        cell.setupGraphDisplay()
        
        // Prevent the ugly selection overlay
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    @IBAction func AddButton(_ sender: Any) {
        //performSegue(withIdentifier: "toAddResult", sender: self)
        showAddActionSheet()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSubjectView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We're about to transition to the article view controller, push all the data we need to display along with it.
        // If the destinationViewController is SubjectTableViewController,
        if let destinationViewController = segue.destination as? SubjectTableViewController {
            let indexPath = tableView.indexPathForSelectedRow
            print("Selected cell #\(indexPath!.row)!")
            let indexPathToPass = indexPath
            destinationViewController.indexPathOfSubject = indexPathToPass?.row
        }
    }
    
    // Action sheet with options (New Result, New Target, Cancel)
    func showAddActionSheet() {
        
        // Main Title and Description
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Add Result
        alert.addAction(UIAlertAction(title: "New Result", style: .default , handler:{ (UIAlertAction)in
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "toAddResult", sender: self) }))
        
        // Add Goal
        alert.addAction(UIAlertAction(title: "New Target", style: .default , handler:{ (UIAlertAction)in
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "toAddGoal", sender: self) }))
        
        // Dismiss
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in alert.dismiss(animated: true, completion: nil) }))
        
        // Present the Action Sheet
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAddGoal() {
        
    }
}
