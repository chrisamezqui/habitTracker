// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension HabitTrackerSchema {
  class AddHabitToRoutineMutation: GraphQLMutation {
    static let operationName: String = "addHabitToRoutine"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"mutation addHabitToRoutine($id: ID!, $habit_id: ID!, $index: Int!) { addHabitToRoutine(id: $id, habit_id: $habit_id, index: $index) { __typename success errors } }"#
      ))

    public var id: ID
    public var habit_id: ID
    public var index: Int

    public init(
      id: ID,
      habit_id: ID,
      index: Int
    ) {
      self.id = id
      self.habit_id = habit_id
      self.index = index
    }

    public var __variables: Variables? { [
      "id": id,
      "habit_id": habit_id,
      "index": index
    ] }

    struct Data: HabitTrackerSchema.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("addHabitToRoutine", AddHabitToRoutine.self, arguments: [
          "id": .variable("id"),
          "habit_id": .variable("habit_id"),
          "index": .variable("index")
        ]),
      ] }

      var addHabitToRoutine: AddHabitToRoutine { __data["addHabitToRoutine"] }

      /// AddHabitToRoutine
      ///
      /// Parent Type: `RoutineResult`
      struct AddHabitToRoutine: HabitTrackerSchema.SelectionSet {
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