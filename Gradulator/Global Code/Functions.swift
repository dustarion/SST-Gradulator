//
//  Functions.swift
//  Gradulator
//
//  Created by Dalton Ng on 5/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import Foundation
import UIKit

// MARK: -
/// Obtain a uiColor from a Hex value.
/// You might need to add a '0x' to the beginning of your Hex value.
//  Porting over a colour over rgb is painful.
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
