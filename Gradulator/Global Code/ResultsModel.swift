//
//  ResultsModel.swift
//  Gradulator
//
//  Created by Dalton Ng on 2/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//
import Foundation

struct ResultsModel: Codable {
    let id: String?
    let user: String?
    let subject: String?
    let goal: Int?
    let currentPercentage : Int?
    let tests: [String]?
    let results: [Int]?
    let weightage: [Double]?
}

/// Legacy Code
/*
 // To allow us to retrieve this data from a plist file.
 init (coder aDecoder: NSCoder!) {
 self.id = (aDecoder.decodeObject(forKey: "id") as! String)
 self.user = (aDecoder.decodeObject(forKey: "user") as! String)
 self.subject = (aDecoder.decodeObject(forKey: "subject") as! String)
 self.goal = (aDecoder.decodeObject(forKey: "goal") as! Int)
 self.currentPercentage = (aDecoder.decodeObject(forKey: "currentPercentage") as! Int)
 self.tests = (aDecoder.decodeObject(forKey: "tests") as! [String])
 self.results = (aDecoder.decodeObject(forKey: "results") as! [Int])
 }
 
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
/*
 class ResultsModel {
 
 var id: String?
 var user: String?
 var subject: String?
 var goal: Int?
 var currentPercentage : Int?
 var tests: [String]?
 var results: [Int]?
 
 init(id: String?, user: String?, subject: String?, goal: Int?, currentPercentage: Int?, tests: [String]?, results: [Int]?){
 self.id = id
 self.user = user
 self.subject = subject
 self.goal = goal
 self.currentPercentage = currentPercentage
 self.tests = tests
 self.results = results
 }
 
 // To allow retrieval
 required convenience init(coder aDecoder: NSCoder) {
 let id = (aDecoder.decodeObject(forKey: "id") as! String)
 let user = (aDecoder.decodeObject(forKey: "user") as! String)
 let subject = (aDecoder.decodeObject(forKey: "subject") as! String)
 let goal = (aDecoder.decodeObject(forKey: "goal") as! Int)
 let currentPercentage = (aDecoder.decodeObject(forKey: "currentPercentage") as! Int)
 let tests = (aDecoder.decodeObject(forKey: "tests") as! [String])
 let results = (aDecoder.decodeObject(forKey: "results") as! [Int])
 self.init(id: id, user: user, subject: subject, goal: goal, currentPercentage: currentPercentage, tests: tests, results: results)
 }
 
 // To allow us to store this data in a plist file.
 func encode(with aCoder: NSCoder) {
 aCoder.encode(id, forKey:"id")
 aCoder.encode(user, forKey:"user")
 aCoder.encode(subject, forKey:"subject")
 aCoder.encode(goal, forKey:"goal")
 aCoder.encode(currentPercentage, forKey:"currentPercentage")
 aCoder.encode(tests, forKey:"tests")
 aCoder.encode(results, forKey:"results")
 }
 }*/
