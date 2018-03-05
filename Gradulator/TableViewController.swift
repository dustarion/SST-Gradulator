//
//  TableViewController.swift
//  Gradulator
//
//  Created by Dalton Ng on 1/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit
import Disk

class TableViewController: UITableViewController {
var resultsList = [ResultsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = uicolorFromHex(rgbValue: 0x434261)
        
        // Obtaining our saved results object from memory
        // TODO: Are there better options for memory persistence
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        cell.setGraphPoints = resultData.results
        cell.subject.text = resultData.subject
        cell.setStartColor = uicolorFromHex(rgbValue: 0x9862FF)
        cell.setEndColor = uicolorFromHex(rgbValue: 0x7C30FE)
        
        // Setting up the cell
        //cell.setGraphPoints = [1, 2, 3, 4, 5, 6, 7]
        //cell.setStartColor = uicolorFromHex(rgbValue: 0x9862FF)
        //cell.setEndColor = uicolorFromHex(rgbValue: 0x7C30FE)
        //cell.subject.text = "Chemistry"
        
        // Append these changes to the cell
        cell.setupGraphDisplay()
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     func setupGraphDisplay(view: GraphView) {
     // Indicate that the graph needs to be redrawn
     view.setNeedsDisplay()
     view.maxLabel.text = "\(view.graphPoints.max()!)"
     
     // Potentially the interferance point to calculate the percentage of the goal!
     //  3 - calculate average from graphPoints
     let average = view.graphPoints.reduce(0, +) / view.graphPoints.count
     view.averageWaterDrunk.text = "\(average)"
     }
     
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
     {
     return 230.0 //Choose your custom row height
     }
    */

}
