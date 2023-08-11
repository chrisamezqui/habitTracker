// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension HabitTrackerSchema {
  class UpdateHabitMutation: GraphQLMutation {
    static let operationName: String = "updateHabit"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"mutation updateHabit($id: ID!, $title: String, $description: String, $lastCompleted: String) { updateHabit( id: $id title: $title description: $description lastCompleted: $lastCompleted ) { __typename habits { __typename id } success errors } }"#
      ))

    public var id: ID
    public var title: GraphQLNullable<String>
    public var description: GraphQLNullable<String>
    public var lastCompleted: GraphQLNullable<String>

    public init(
      id: ID,
      title: GraphQLNullable<String>,
      description: GraphQLNullable<String>,
      lastCompleted: GraphQLNullable<String>
    ) {
      self.id = id
      self.title = title
      self.description = description
      self.lastCompleted = lastCompleted
    }

    public var __variables: Variables? { [
      "id": id,
      "title": title,
      "description": description,
      "lastCompleted": lastCompleted
    ] }

    struct Data: HabitTrackerSchema.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("updateHabit", UpdateHabit.self, arguments: [
          "id": .variable("id"),
          "title": .variable("title"),
          "description": .variable("description"),
          "lastCompleted": .variable("lastCompleted")
        ]),
      ] }

      var updateHabit: UpdateHabit { __data["updateHabit"] }

      /// UpdateHabit
      ///
      /// Parent Type: `HabitResult`
      struct UpdateHabit: HabitTrackerSchema.SelectionSet {
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

        /// UpdateHabit.Habit
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