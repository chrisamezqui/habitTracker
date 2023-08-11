// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension HabitTrackerSchema {
  class DeleteHabitMutation: GraphQLMutation {
    static let operationName: String = "deleteHabit"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"mutation deleteHabit($id: ID!) { deleteHabit(id: $id) { __typename habits { __typename id } success errors } }"#
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
        .field("deleteHabit", DeleteHabit.self, arguments: ["id": .variable("id")]),
      ] }

      var deleteHabit: DeleteHabit { __data["deleteHabit"] }

      /// DeleteHabit
      ///
      /// Parent Type: `HabitResult`
      struct DeleteHabit: HabitTrackerSchema.SelectionSet {
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

        /// DeleteHabit.Habit
        ///
        /// Parent Type: `Habit`
        struct Habit: HabitTrackerSchema.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Habit }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("id", HabitTrackerSchema.ID.self),
          ] }

          var id: HabitTrackerSchema.ID { __data["id"] }
        }
      }
    }
  }

}