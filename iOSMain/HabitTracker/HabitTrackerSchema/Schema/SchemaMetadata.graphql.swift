// @generated
// This file was automatically generated and should not be edited.

import Apollo

protocol HabitTrackerSchema_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == HabitTrackerSchema.SchemaMetadata {}

protocol HabitTrackerSchema_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == HabitTrackerSchema.SchemaMetadata {}

protocol HabitTrackerSchema_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == HabitTrackerSchema.SchemaMetadata {}

protocol HabitTrackerSchema_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == HabitTrackerSchema.SchemaMetadata {}

extension HabitTrackerSchema {
  typealias ID = String

  typealias SelectionSet = HabitTrackerSchema_SelectionSet

  typealias InlineFragment = HabitTrackerSchema_InlineFragment

  typealias MutableSelectionSet = HabitTrackerSchema_MutableSelectionSet

  typealias MutableInlineFragment = HabitTrackerSchema_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    static let configuration: Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Query": return HabitTrackerSchema.Objects.Query
      case "HabitResult": return HabitTrackerSchema.Objects.HabitResult
      case "Habit": return HabitTrackerSchema.Objects.Habit
      case "Routine": return HabitTrackerSchema.Objects.Routine
      case "RoutineResult": return HabitTrackerSchema.Objects.RoutineResult
      case "Mutation": return HabitTrackerSchema.Objects.Mutation
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}