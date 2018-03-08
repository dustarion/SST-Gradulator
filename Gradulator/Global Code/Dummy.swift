//
//  dummy.swift
//  Gradulator
//
//  Created by Dalton Ng on 5/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//
import Foundation
import Disk

/// Purpose of this file is to hold functions that insert dummy data for the purpose of testing.
/// Remove all calls to this file for production.

func insertDummyResults() {
    insertDummyResults1()
    insertDummyResults2()
    insertDummyResults3()
    do {
        try Disk.save(resultsList, to: .documents, as: "Gradulator/Results.json")
    } catch {
        print(error.localizedDescription)
    }
}


func insertDummyResults1() {
    // Define our dummy data

    let id  = "1"
    let user = "Local"
    let subject = "Chemistry"
    let goal = 75
    let currentPercentage = 35
    let tests = ["CA1", "SA1", "CA2", "SA2"]
    let results = [10, 5, 50, 75]
    let weightage = [25.0, 25.0, 25.0, 25.0]
    resultsList.append(ResultsModel(id: id, user: user, subject: subject, goal: goal, currentPercentage: currentPercentage, tests: tests, results: results, weightage: weightage))
}

func insertDummyResults2() {
    // Define our dummy data
    
    let id  = "2"
    let user = "Local"
    let subject = "Physics"
    let goal = 100
    let currentPercentage = 61
    let tests = ["CA1", "SA1", "CA2", "SA2"]
    let results = [50, 75, 50, 70]
    let weightage = [25.0, 25.0, 35.0, 15.0]
    resultsList.append(ResultsModel(id: id, user: user, subject: subject, goal: goal, currentPercentage: currentPercentage, tests: tests, results: results, weightage: weightage))
}

func insertDummyResults3() {
    // Define our dummy data
    
    let id  = "3"
    let user = "Local"
    let subject = "English"
    let goal = 50
    let currentPercentage = 50
    let tests = ["SA1", "CA2", "SA2"]
    let results = [60, 70, 30]
    let weightage = [10.0, 40.0, 25.0]
    resultsList.append(ResultsModel(id: id, user: user, subject: subject, goal: goal, currentPercentage: currentPercentage, tests: tests, results: results, weightage: weightage
    ))
}
