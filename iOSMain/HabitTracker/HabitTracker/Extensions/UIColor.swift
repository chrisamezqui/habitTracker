//
//  UIColor.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 8/7/23.
//

import UIKit

extension UIColor {
    
    static func habitCardDefaultColor() -> UIColor {
        return UIColor(red:0.95 , green:0.95 , blue:0.9 , alpha: 1)
    }
    
    static func habitCardCompleteColor() -> UIColor {
        return UIColor(red:0.7 , green:1.0 , blue:0.7 , alpha: 1)
    }
    
    static func primaryTextColor() -> UIColor {
        return UIColor.black
    }
    
    static func secondaryTextColor() -> UIColor {
        return UIColor.darkGray
    }
}
