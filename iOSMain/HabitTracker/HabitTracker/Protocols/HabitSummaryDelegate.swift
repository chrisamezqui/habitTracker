//
//  HabitSummaryDelegate.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 8/4/23.
//

import Foundation

protocol HabitSummaryDelegate {
    func didSingleTapOnCollectionViewCell(_ cell: HabitSummaryCollectionViewCell)
    func didDoubleTapOnCollectionViewCell(_ cell: HabitSummaryCollectionViewCell)
}
