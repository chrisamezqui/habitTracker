//
//  RoutineCellDelegate.swift
//  HabitTracker
//
//  Created by Chris Amezquita on 8/9/23.
//

import Foundation

protocol RoutineCellDelegate {
    func didSingleTapOnCollectionViewCell(_ cell: RoutinesCollectionViewCell)
    func didDoubleTapOnCollectionViewCell(_ cell: RoutinesCollectionViewCell)
}
