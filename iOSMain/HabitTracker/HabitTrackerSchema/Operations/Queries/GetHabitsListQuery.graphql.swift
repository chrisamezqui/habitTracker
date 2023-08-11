// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension HabitTrackerSchema {
  class GetHabitsListQuery: GraphQLQuery {
    static let operationName: String = "GetHabitsList"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"query GetHabitsList { getHabits { __typename success errors habits { __typename id title description streak_count last_completed is_complete routines { __typename id title } } } }"#
      ))

    public init() {}

    struct Data: HabitTrackerSchema.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("getHabits", GetHabits.self),
      ] }

      var getHabits: GetHabits { __data["getHabits"] }

      /// GetHabits
      ///
      /// Parent Type: `HabitResult`
      struct GetHabits: HabitTrackerSchema.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.HabitResult }
        static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("success", Bool.self),
          .field("errors", [String?]?.self),
          .field("habits", [Habit?]?.self),
        ] }

        var success: Bool { __data["success"] }
        var errors: [String?]? { __data["errors"] }
        var habits: [Habit?]? { __data["habits"] }

        /// GetHabits.Habit
        ///
        /// Parent Type: `Habit`
        struct Habit: HabitTrackerSchema.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Habit }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("id", HabitTrackerSchema.ID.self),
            .field("title", String.self),
            .field("description", String?.self),
            .field("streak_count", Int?.self),
            .field("last_completed", String?.self),
            .field("is_complete", Bool?.self),
            .field("routines", [Routine?]?.self),
          ] }

          var id: HabitTrackerSchema.ID { __data["id"] }
          var title: String { __data["title"] }
          var description: String? { __data["description"] }
          var streak_count: Int? { __data["streak_count"] }
          var last_completed: String? { __data["last_completed"] }
          var is_complete: Bool? { __data["is_complete"] }
          var routines: [Routine?]? { __data["routines"] }

          /// GetHabits.Habit.Routine
          ///
          /// Parent Type: `Routine`
          struct Routine: HabitTrackerSchema.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Routine }
            static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("id", HabitTrackerSchema.ID.self),
              .field("title", String.self),
            ] }

            var id: HabitTrackerSchema.ID { __data["id"] }
            var title: String { __data["title"] }
          }
        }
      }
    }
  }

}