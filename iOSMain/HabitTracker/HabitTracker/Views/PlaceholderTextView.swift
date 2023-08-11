//
//  PlaceholderTextView.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/31/23.
//

import UIKit

class PlaceholderTextView: UITextView {
    
    var placeholderText : String? {
        didSet {
            showPlaceholderText()
        }
    }
    
    private(set) var placeholderTextIsVisible : Bool = false
    
    func hidePlaceholderText() {
        textColor = .black
        text = nil
        placeholderTextIsVisible = false
    }
    
    func showPlaceholderText() {
        if placeholderText != nil {
            textColor = .lightGray
            placeholderTextIsVisible = true
            text = placeholderText
        }
    }
}
