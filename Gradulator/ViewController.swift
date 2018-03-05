//
//  ViewController.swift
//  Gradulator
//
//  Created by Dalton Ng on 1/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var graphView: GraphView!
    
    //Label Outlets Graph
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    //@IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupGraphDisplay() {
        
        //let maxDayIndex = stackView.arrangedSubviews.count - 1
        
        //  1 - replace last day with today's actual data
        //graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        //2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        maxLabel.text = "\(graphView.graphPoints.max()!)"
        
        // Potentially the interferance point to calculate the percentage of the goal!
        //  3 - calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        // 4 - setup date formatter and calendar
        //let today = Date()
        //let calendar = Calendar.current
        
        //let formatter = DateFormatter()
        //formatter.setLocalizedDateFormatFromTemplate("EEEEE")
        
        // 5 - set up the day name labels with correct days
        /*
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today),
                let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }*/
    }
}

