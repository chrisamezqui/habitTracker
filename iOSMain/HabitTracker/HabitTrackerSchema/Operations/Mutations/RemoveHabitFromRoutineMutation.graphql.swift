// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension HabitTrackerSchema {
  class RemoveHabitFromRoutineMutation: GraphQLMutation {
    static let operationName: String = "removeHabitFromRoutine"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"mutation removeHabitFromRoutine($habit_id: ID!, $routine_id: ID!) { removeHabitFromRoutine(habit_id: $habit_id, routine_id: $routine_id) { __typename success errors } }"#
      ))

    public var habit_id: ID
    public var routine_id: ID

    public init(
      habit_id: ID,
      routine_id: ID
    ) {
      self.habit_id = habit_id
      self.routine_id = routine_id
    }

    public var __variables: Variables? { [
      "habit_id": habit_id,
      "routine_id": routine_id
    ] }

    struct Data: HabitTrackerSchema.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("removeHabitFromRoutine", RemoveHabitFromRoutine.self, arguments: [
          "habit_id": .variable("habit_id"),
          "routine_id": .variable("routine_id")
        ]),
      ] }

      var removeHabitFromRoutine: RemoveHabitFromRoutine { __data["removeHabitFromRoutine"] }

      /// RemoveHabitFromRoutine
      ///
      /// Parent Type: `RoutineResult`
      struct RemoveHabitFromRoutine: HabitTrackerSchema.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.RoutineResult }
        static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("success", Bool.self),
          .field("errors", [String?]?.self),
        ] }

        var success: Bool { __data["success"] }
        var errors: [String?]? { __data["errors"] }
      }
    }
  }

}