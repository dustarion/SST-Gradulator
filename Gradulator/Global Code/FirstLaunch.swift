//
//  firstLaunch.swift
//  Gradulator
//
//  Created by Dalton Ng on 7/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import Foundation
import UIKit

// MARK: -
/// The purpose of this file is to hold code that will execute on application launch.
/// Future plans would try to retrieve updated lists from firebase but for now, these are hardcoded.

// MARK: -
/// Executes on first time the application is launched.
func setupFirstLaunchOfApp () {
    
    // Insert the predefined array of subjects.
    // TODO: Create more values here.
    let subjects = ["English", "Malay", "Tamil", "Chinese",
                    "Physics", "Biology", "Chemistry",
                    "Science", "Combined Science", ]
    subjects.forEach { (newSubject) in
        saveNewSubjectToDisk(subject: newSubject)
    }
    
    // Insert the predefined array of testnames.
    // TODO: Create more values here.
    let tests = ["CA1", "CA2", "SA1", "SA2",
                 "Level Test 1", "Level Test 2", "Common Test 1", "Common Test 2",
                 "Mid Year Exam", "O Level"]
    tests.forEach { (newTestname) in
        saveNewTestToDisk(test: newTestname)
    }
}

// MARK: -
/// Setup the NavBar to look pretty.
func setupNavBar () {
    // Setup our custom navigation bar
    //UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().shadowImage = UIImage()
    //UINavigationBar.appearance().backgroundColor = uicolorFromHex(rgbValue: 0x28384D)
    UINavigationBar.appearance().isTranslucent = true
    UINavigationBar.appearance().tintColor = uicolorFromHex(rgbValue: 0xffffff)
    UINavigationBar.appearance().barTintColor = uicolorFromHex(rgbValue: 0x434261)
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
}
