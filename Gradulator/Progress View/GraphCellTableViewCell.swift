//
//  GraphCellTableViewCell.swift
//  Gradulator
//
//  Created by Dalton Ng on 1/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit

class GraphCellTableViewCell: UITableViewCell {
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var graphView: GraphView!
    
    //Label Outlets Graph
    @IBOutlet weak var averageValue: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    // Outlets to allow customisation of the graph from the UITableViewController
    var setGraphPoints: [Int]?
    
    // Outlets to allow customisation of the gradient that underlines the cell
    var setStartColor: UIColor?
    var setEndColor: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupGraphDisplay()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupGraphDisplay() {
        
        // Ensure we don't accidentally crash, we'll display an empty graph alternatively
        if setGraphPoints == nil {
            setGraphPoints = [0, 0, 0, 0, 0, 0, 0]
        }
        
        // Append the actual data or our dummy data to the actual graph
        graphView.graphPoints = setGraphPoints!
        
        // Indicate that the graph needs to be redrawn with the new data
        graphView.setNeedsDisplay()
        
        // Set a custom gradient, we'll define the values in the cell for index row function OR we'll use the default gradient setup in GraphView.swift.
        graphView.startColor = setStartColor
        graphView.endColor = setEndColor
        
        // Setup the maxLabel.text to show the maximum point on the graph
        // TODO : This should instead display the user defined goal. Default goal will be 100%
        maxLabel.text = "\(graphView.graphPoints.max()!)"
        
        // TODO : Calculate the percentage of the goal achieved
        // Calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageValue.text = "\(average)"
    }
}
