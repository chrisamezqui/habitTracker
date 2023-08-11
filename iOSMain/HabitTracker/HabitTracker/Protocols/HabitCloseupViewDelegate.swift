//
//  HabitCloseupViewDelegate.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 8/2/23.
//

import UIKit

protocol HabitCloseupViewDelegate {
    func closeupView(_ closeupView : HabitCloseupView, didTapCancelButton : UIButton)
    func closeupView(_ closeupView : HabitCloseupView, didTapSaveButton: UIButton)

}
