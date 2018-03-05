//
//  dummy.swift
//  Gradulator
//
//  Created by Dalton Ng on 5/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//
/*
 var id: String?
 var user: String?
 var subject: String?
 var goal: Int?
 var currentPercentage : Int?
 var tests: [String]?
 var results: [Int]?
 */
import Foundation

/// Purpose of this file is to hold functions that insert dummy data for the purpose of testing.
var resultsList = [ResultsModel]()

func insertDummyResults() {
    insertDummyResults1()
    insertDummyResults2()
    insertDummyResults3()
    
    let userDefaults = UserDefaults.standard
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: resultsList)
    userDefaults.set(encodedData, forKey: "Results")
    userDefaults.synchronize()
}


func insertDummyResults1() {
    // Define our dummy data

    let id  = "1"
    let user = "test"
    let subject = "Chemistry"
    let goal = 75
    let currentPercentage = 35
    let tests = ["CA1", "SA1", "CA2", "SA2"]
    let results = [10, 5, 50, 75]
    resultsList.append(ResultsModel(id: id, user: user, subject: subject, goal: goal, currentPercentage: currentPercentage, tests: tests, results: results))
}

func insertDummyResults2() {
    // Define our dummy data
    
    let id  = "2"
    let user = "test"
    let subject = "Physics"
    let goal = 100
    let currentPercentage = 61
    let tests = ["CA1", "SA1", "CA2", "SA2"]
    let results = [50, 75, 50, 70]
    resultsList.append(ResultsModel(id: id, user: user, subject: subject, goal: goal, currentPercentage: currentPercentage, tests: tests, results: results))
}

func insertDummyResults3() {
    // Define our dummy data
    
    let id  = "3"
    let user = "test"
    let subject = "English"
    let goal = 60
    let currentPercentage = 50
    let tests = ["CA1", "SA1", "CA2", "SA2"]
    let results = [40, 60, 70, 30]
    resultsList.append(ResultsModel(id: id, user: user, subject: subject, goal: goal, currentPercentage: currentPercentage, tests: tests, results: results))
}











/*
 
 let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.allDomainsMask, true)
 let path: AnyObject = paths[0] as AnyObject
 let arrPath = path.appending("/ResultsModel.plist")
 //NSKeyedArchiver.archiveRootObject(peopleArray, toFile: arrPath)
 
 Storing the array :
 let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
 let path: AnyObject = paths[0]
 let arrPath = path.stringByAppendingString("/ResultsModel.plist")
 NSKeyedArchiver.archiveRootObject(peopleArray, toFile: arrPath)
 
 Retrieving :
 if let tempArr: [ResultsModel] = NSKeyedUnarchiver.unarchiveObjectWithFile(arrPath) as? [ResultsModel] {
 peopleArray = tempArr
 }
 */
