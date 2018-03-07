//
//  Functions.swift
//  Gradulator
//
//  Created by Dalton Ng on 5/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import Foundation
import UIKit
import Disk

// Global Objects
var resultsList = [ResultsModel]()
var subjectList = [String]()
var testsList = [String]()

// MARK: -
/// Obtain a uiColor from a Hex value.
/// You might need to add a '0x' to the beginning of your Hex value.
func uicolorFromHex(rgbValue:UInt32)->UIColor{
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    
    return UIColor(red:red, green:green, blue:blue, alpha:1.0)
}

// MARK: -
/// Add padding to the beginning of a textfield.
/// paddingAmount must be an integer.
func addPaddingToTextfield (paddingAmount: Int, textfield: UITextField) {
    let paddingHeight = UIView(frame: CGRect(x: 0, y: 0, width: paddingAmount, height: Int(textfield.frame.height)))
    textfield.leftView = paddingHeight
    textfield.leftViewMode = UITextFieldViewMode.always
}

// MARK: -
/// Calculate Grade based on a percentage using Singapore's Academic Grading System. Returns as a String.
/// TODO: Provide support for multiple grading systems internationally.
/// Based on the table found at : https://en.wikipedia.org/wiki/Academic_grading_in_Singapore.
func returnGrade (ofPercentage: Int) -> String {
    if ofPercentage > 100 {
        print("Error : Percentage too large")
        return "Error"
    }
    else {
        switch ofPercentage {
            case 0..<40:
                return "F9"
            case 40..<45:
                return "E8"
            case 45..<50:
                return "D7"
            case 50..<55:
                return "C6"
            case 55..<60:
                return "C5"
            case 60..<65:
                return "B4"
            case 65..<70:
                return "B3"
            case 70..<75:
                return "A2"
            case 75...100:
                return "A1"
            default:
                print("Error : Percentage too small")
                return "Error"
            }
    }
}

// MARK: -
/// Return the percentage of a given Grade as a float. (e.g A1 returns 75)
/// Prefer given grade in the format F9, but will still return a suitable percentage for the case of f9.
/// If the given grade doesn't exist, we will return 75, a default of A1
/// TODO: Provide support for multiple grading systems internationally.
/// Based on the table found at : https://en.wikipedia.org/wiki/Academic_grading_in_Singapore.
func returnPercentage (ofGrade: String) -> Double {
    switch ofGrade {
    case "F9","f9":
        return 0
    case "E8","e8":
        return 40
    case "D7","d7":
        return 45
    case "C6","c6":
        return 50
    case "C5","c5":
        return 55
    case "B4","b4":
        return 60
    case "B3","b3":
        return 65
    case "A2","a2":
        return 70
    case "A1","a1":
        return 75
    default:
        // Setting to a default of A1
        return 75
    }
}

// MARK: -
/// Return the remaining weightage available after removing everything else.
/// Uses the contents of results list.
func returnRemainingWeightage (ofSubject: String) -> Double {
    // Obtain an individual ResultData object for the subject in question.
    let subjectData = resultsList.first(where: { $0.subject == ofSubject })
    
    // If there is data in subjectData
    if !(subjectData == nil) {
    
        // Further filter to obtain the array of weightages
        let weightageArray = subjectData?.weightage
        
        // Add up the elements in the array to find the total weightage
        // 100 - above value to get remaining weightage
        let remainingweightage = 100.0 - (weightageArray?.reduce(0, +))!
        
        // Return the remaining weightage, if there are no elements, it should return 100.
        return remainingweightage
    }
        
    // The expected subjectData doesn't exist, likely first time creation, return 100.
    else {
        return 100.0
    }
}

// MARK: -
/// Return the calculated weightage.
func calculateWeightage (percentage: Int, weightage: Double) -> Double {
    let percentageDouble = Double(percentage)
    let calculatedWeightage = percentageDouble * (weightage / 100)
    return calculatedWeightage
}

// MARK: -
/// Calculates how much to score on next test.
/// Can return a value greater than 100 or a negative value.
/// For purposes of informing the user if obtaining goal is not possible, greater than 100 will be handled in viewcontroller.
func returnScoreNextTest (underSubject: String, percentage: Int, weightage: Double) -> Int {
    
    // Obtain an individual ResultData object for the subject in question.
    let subjectData = resultsList.first(where: { $0.subject == underSubject })
    // If there is data in subjectData
    if !(subjectData == nil) {
        
        var resultsArray = subjectData?.results
        resultsArray?.append(percentage)
        
        var weightagesArray = subjectData?.weightage
        weightagesArray?.append(weightage)
        
        var WeightagesTotalArray: [Double] = []
        for (perc, weight) in zip(resultsArray!, weightagesArray!) {
            WeightagesTotalArray.append(calculateWeightage(percentage: perc, weightage: weight))
        }
        print(WeightagesTotalArray)
        
        if !(subjectData?.goal == nil) {
            let markToScoreNextTest = ( ( ( Double((subjectData?.goal)!) - (WeightagesTotalArray.reduce(0, +)) ) / returnRemainingWeightage(ofSubject: underSubject) ) * 100 )
            return Int(markToScoreNextTest)
        }
            
        // No goal set, defaulting to a default goal of 75% or A1
        else {
            return 75
        }
    }
        
    // The expected subjectData doesn't exist, likely first time creation, return 75.
    else {
        return 75
    }
}

// MARK: -
/// This function relies on Disk, found in pods.
/// This will save the current state of resultsList to disk.
func saveCurrentStateOfresultsList () {
    do {
        try Disk.save(resultsList, to: .documents, as: "Gradulator/Results.json")
    } catch {
        print(error.localizedDescription)
    }
}

// MARK: -
/// This function relies on Disk, found in pods.
/// Will append a new result to its existing place or create a new subject in resultsList.
/// Calls saveCurrentStateOfresultsList() in order to save to Disk
func saveNewResultToDisk (ofSubject: String, withTestname: String, withResult: Int, withWeightage: Double) {
    // Check if there is an existing entry in our Results.json for the specified subject
    if resultsList.contains(where: { $0.subject == ofSubject }) {
        // There is an existing entry, lets append the data to it
        let indexValue = resultsList.index(where: { $0.subject == ofSubject })
        // Add these to the global resultsList
        resultsList[indexValue!].tests?.append(withTestname)
        resultsList[indexValue!].results?.append(withResult)
        resultsList[indexValue!].weightage?.append(withWeightage)
        
        // Save To Disk
        saveCurrentStateOfresultsList()
    } else {
        // The subject doesn't exist, its a new subject.
        // Create a new object for this subject.
        let id  = String(resultsList.count + 1)
        let user = "Local"
        let subject = ofSubject
        let goal = 75
        let currentPercentage = 0
        let tests = [withTestname]
        let results = [withResult]
        let weightage = [withWeightage]
        resultsList.append(ResultsModel(id: id, user: user, subject: subject, goal: goal, currentPercentage: currentPercentage, tests: tests, results: results, weightage: weightage))
        // Save to Disk
        saveCurrentStateOfresultsList()
    }
}

// MARK: -
/// This function relies on Disk, found in pods.
/// Will append or update a new goal to its existing place or create a new goal in resultsList.
/// Calls saveCurrentStateOfresultsList() in order to save to Disk
func saveNewGoalToDisk (ofSubject: String, ofGoal: Int) {
    // Check if there is an existing entry in our Results.json for the specified subject
    if resultsList.contains(where: { $0.subject == ofSubject }) {
        // There is an existing entry, lets append the data to it
        let indexValue = resultsList.index(where: { $0.subject == ofSubject })
        // Add these to the global resultsList
        resultsList[indexValue!].goal = ofGoal
        // Save To Disk
        saveCurrentStateOfresultsList()
    } else {
        // The subject doesn't exist, its a new subject.
        // Create a new object for this subject.
        let id  = String(resultsList.count + 1)
        let user = "Local"
        let subject = ofSubject
        let goal = ofGoal
        let currentPercentage = 0
        let tests = [String]()
        let results = [Int]()
        let weightage = [Double]()
        resultsList.append(ResultsModel(id: id, user: user, subject: subject, goal: goal, currentPercentage: currentPercentage, tests: tests, results: results, weightage: weightage))
        // Save to Disk
        saveCurrentStateOfresultsList()
    }
}

// MARK: -
/// This function relies on Disk, found in pods.
/// This will save the current state of subjectList to disk.
func saveCurrentStateOfsubjectList () {
    do {
        try Disk.save(subjectList, to: .documents, as: "Gradulator/Subjects.json")
    } catch {
        print(error.localizedDescription)
    }
}

// MARK: -
/// This function relies on Disk, found in pods.
/// Will add a new subject to the stored array of subjects.
/// Purely to make it easier for the user to add results
func saveNewSubjectToDisk(subject: String) {
    // Double check if the subject already exists just for safety reasons
    if !(subjectList.contains(subject)) {
        subjectList.append(subject)
        saveCurrentStateOfsubjectList()
    }
    else { return }
}

// MARK: -
/// This function relies on Disk, found in pods.
/// This will save the current state of testsList to disk.
func saveCurrentStateOftestsList () {
    do {
        try Disk.save(testsList, to: .documents, as: "Gradulator/Tests.json")
    } catch {
        print(error.localizedDescription)
    }
}

// MARK: -
/// This function relies on Disk, found in pods.
/// Will add a new testName to the stored array of testnames.
/// Purely to make it easier for the user to add results
func saveNewTestToDisk(test: String) {
    // Double check if the test already exists just for safety reasons
    if !(testsList.contains(test)) {
        subjectList.append(test)
        saveCurrentStateOftestsList()
    }
    else { return }
}

func testDividible (int: Int, by:Int) -> Bool {
    if int % by == 0 { return true }
    else { return false }
}

// MARK: -
/// This function returns an array of 2 hexvalues which are a gradient, used for making the main ui look nice.
/// Currentlyy contains purple green orange or pink.
/// To designate a specific colour pass a value from 0 - 3 into the function.
/// 0 returns purple, 1 returns green, 2 returns Orange, 3 returns Pinks
/// returns [startColour, endColour]
func generateGradient (indexValue: Int) -> [UInt32] {
    
                         // Purple      Green       Orange      Pink
    let startColourArray =  [0x9862FF,  0x2AF598,   0xFF9B0B,   0xFE6A88]
    let endColourArray =    [0x7C30FE,  0x08AEEA,   0xFD4F00,   0xC850C0]
    
    // If indexvalue is 0...3.
    if (indexValue >= 0) && (indexValue <= 3) {
        return [UInt32(startColourArray[indexValue]), UInt32(endColourArray[indexValue])]
    }
        
    // If indexvalue is greater than 3.
    // Effectively loop through the array such that passing 4 would return the object at index 0, and so forth.
    else if (indexValue > 3) {
        let indexLoopedValue = indexValue % 4
        return [UInt32(startColourArray[indexLoopedValue]), UInt32(endColourArray[indexLoopedValue])]
    }
    
    // Likely will never be executed, exists for safety reasons only.
    else {
        return [UInt32(startColourArray[0]), UInt32(endColourArray[0])]
    }
}
