//
//  ResultsModel.swift
//  Gradulator
//
//  Created by Dalton Ng on 2/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//
import Foundation

/// Stores the results under a subject
struct ResultsModel: Codable {
    var id: String?
    var user: String?
    var subject: String?
    var goal: Int?
    var currentPercentage : Int?
    var tests: [String]?
    var results: [Int]?
    var weightage: [Double]?
}
