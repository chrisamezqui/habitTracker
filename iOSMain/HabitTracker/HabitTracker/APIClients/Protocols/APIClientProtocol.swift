//
//  APIClientProtocol.swift
//  HabitTracker
//
//  Created by Chris Amezquita on 8/11/23.
//

import Foundation

protocol APIClientProtocol {
    
    typealias habitType = HabitTrackerSchema.GetHabitsListQuery.Data.GetHabits.Habit
    
    typealias habitIdentifierType = HabitTrackerSchema.ID
    typealias routineIdentifierType = HabitTrackerSchema.ID
    
    func getAllHabits(forceReload : Bool?)
    
    func updateHabit(withId habitId: habitIdentifierType, newTitle: String, newDescription: String, forceReload: Bool?)
    
    func createHabit(withId habitId: habitIdentifierType, title: String, description: String, forceReload: Bool?)
    
    func deleteHabit(withId habitId: habitIdentifierType, forceReload: Bool?)
    
    func getAllRoutines(withId routineId: routineIdentifierType, forceReload: Bool?)
    
    func createRoutine(withId routineId: routineIdentifierType, title : String?, forceReload: Bool?)
    
    func deleteRoutine(withId routineId: routineIdentifierType, forceReload: Bool?)
    
    func updateRoutine(withId routineId: routineIdentifierType, newTitle: String, forceReload: Bool?)
    
    func addHabitToRoutine(withRoutineId routineId: routineIdentifierType, habitId: habitIdentifierType, forceReload: Bool?)
    
    func removeHabitFromRoutine(withRoutineId routineId: routineIdentifierType, habitId: habitIdentifierType, forceReload: Bool?)
}
