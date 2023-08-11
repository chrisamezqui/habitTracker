// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension HabitTrackerSchema {
  class CompleteHabitMutation: GraphQLMutation {
    static let operationName: String = "completeHabit"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"mutation completeHabit($id: ID!) { completeHabit(id: $id) { __typename habits { __typename id is_complete streak_count last_completed } success errors } }"#
      ))

    public var id: ID

    public init(id: ID) {
      self.id = id
    }

    public var __variables: Variables? { ["id": id] }

    struct Data: HabitTrackerSchema.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("completeHabit", CompleteHabit.self, arguments: ["id": .variable("id")]),
      ] }

      var completeHabit: CompleteHabit { __data["completeHabit"] }

      /// CompleteHabit
      ///
      /// Parent Type: `HabitResult`
      struct CompleteHabit: HabitTrackerSchema.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.HabitResult }
        static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("habits", [Habit?]?.self),
          .field("success", Bool.self),
          .field("errors", [String?]?.self),
        ] }

        var habits: [Habit?]? { __data["habits"] }
        var success: Bool { __data["success"] }
        var errors: [String?]? { __data["errors"] }

        /// CompleteHabit.Habit
        ///
        /// Parent Type: `Habit`
        struct Habit: HabitTrackerSchema.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Habit }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("id", HabitTrackerSchema.ID.self),
            .field("is_complete", Bool?.self),
            .field("streak_count", Int?.self),
            .field("last_completed", String?.self),
          ] }

          var id: HabitTrackerSchema.ID { __data["id"] }
          var is_complete: Bool? { __data["is_complete"] }
          var streak_count: Int? { __data["streak_count"] }
          var last_completed: String? { __data["last_completed"] }
        }
      }
    }
  }

}