//
//  HabitListViewControllerDelegate.swift
//  HabitTracker
//
//  Created by Chris Amezquita on 8/8/23.
//

import Foundation

protocol HabitListViewControllerDelegate {
    func habitListViewController(_ viewController : HabitListViewController, didAddHabitWithID id: HabitTrackerSchema.ID)
}
