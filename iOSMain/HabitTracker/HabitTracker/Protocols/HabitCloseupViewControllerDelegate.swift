//
//  HabitCloseupViewControllerDelegate.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 8/2/23.
//

import Foundation

protocol HabitCloseupViewControllerDelegate {
    func didCreateNewHabit(withTitle: String, description: String)
    
    func didUpdateHabit(withId: HabitTrackerSchema.ID, title: String, description: String)
    
    func closeupViewController(_ viewController: HabitCloseupViewController, didDeleteHabitWithId habit_id: HabitTrackerSchema.ID)
}
