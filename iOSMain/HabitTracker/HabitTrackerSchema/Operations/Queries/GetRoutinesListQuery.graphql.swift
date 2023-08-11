// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension HabitTrackerSchema {
  class GetRoutinesListQuery: GraphQLQuery {
    static let operationName: String = "GetRoutinesList"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"query GetRoutinesList { getRoutines { __typename success errors routines { __typename id title habits { __typename id title description last_completed streak_count } } } }"#
      ))

    public init() {}

    struct Data: HabitTrackerSchema.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("getRoutines", GetRoutines.self),
      ] }

      var getRoutines: GetRoutines { __data["getRoutines"] }

      /// GetRoutines
      ///
      /// Parent Type: `RoutineResult`
      struct GetRoutines: HabitTrackerSchema.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.RoutineResult }
        static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("success", Bool.self),
          .field("errors", [String?]?.self),
          .field("routines", [Routine?]?.self),
        ] }

        var success: Bool { __data["success"] }
        var errors: [String?]? { __data["errors"] }
        var routines: [Routine?]? { __data["routines"] }

        /// GetRoutines.Routine
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
            .field("habits", [Habit?]?.self),
          ] }

          var id: HabitTrackerSchema.ID { __data["id"] }
          var title: String { __data["title"] }
          var habits: [Habit?]? { __data["habits"] }

          /// GetRoutines.Routine.Habit
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
              .field("last_completed", String?.self),
              .field("streak_count", Int?.self),
            ] }

            var id: HabitTrackerSchema.ID { __data["id"] }
            var title: String { __data["title"] }
            var description: String? { __data["description"] }
            var last_completed: String? { __data["last_completed"] }
            var streak_count: Int? { __data["streak_count"] }
          }
        }
      }
    }
  }

}