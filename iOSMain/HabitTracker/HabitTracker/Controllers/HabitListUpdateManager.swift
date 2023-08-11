//
//  HabitListUpdateManager.swift
//  HabitTracker
//
//  Created by Chris Amezquita on 8/11/23.
//

import Foundation

struct HabitListUpdateManager<SectionIdentifierType, ItemIdentifierType> where SectionIdentifierType : Hashable, SectionIdentifierType : Sendable, ItemIdentifierType : Hashable, ItemIdentifierType : Sendable{
    
    enum UpdateOperation {
        case edit
        case create
        case complete
    }
    private(set) var habitID : ItemIdentifierType?
    private(set) var curOperation : UpdateOperation?
    
    mutating func willEditHabit(withId id: ItemIdentifierType) {
        habitID = id
        curOperation = .edit
    }
    
    mutating func willCreateHabit(withId id: ItemIdentifierType) {
        habitID = id
        curOperation = .create
    }
    
    mutating func willCompleteHabit(withId id: ItemIdentifierType) {
        habitID = id
        curOperation = .complete
    }
    
    mutating func updateSnapshot(_ snapshot : inout NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>, withIdentifiers habitIdentifiers : [ItemIdentifierType] ) {
        if curOperation != nil && habitID != nil {
            switch(curOperation) {
                case .complete:
                    snapshot.reconfigureItems([habitID!])
                case .create:
                    snapshot.appendItems([habitID!])
                case .edit:
                    snapshot.reconfigureItems([habitID!])
                case .none:
                    fatalError("curOpertion is .none")
            }
            habitID = nil
            curOperation = nil
        } else {
            snapshot.appendItems(habitIdentifiers)
        }
        
    }
    
}
