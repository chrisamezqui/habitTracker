// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension HabitTrackerSchema {
  class CreateHabitMutation: GraphQLMutation {
    static let operationName: String = "createHabit"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"mutation createHabit($title: String!, $description: String!) { createHabit(title: $title, description: $description) { __typename habits { __typename id } success errors } }"#
      ))

    public var title: String
    public var description: String

    public init(
      title: String,
      description: String
    ) {
      self.title = title
      self.description = description
    }

    public var __variables: Variables? { [
      "title": title,
      "description": description
    ] }

    struct Data: HabitTrackerSchema.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { HabitTrackerSchema.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("createHabit", CreateHabit.self, arguments: [
          "title": .variable("title"),
          "description": .variable("description")
        ]),
      ] }

      var createHabit: CreateHabit { __data["createHabit"] }

      /// CreateHabit
      ///
      /// Parent Type: `HabitResult`
      struct CreateHabit: HabitTrackerSchema.SelectionSet {
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

        /// CreateHabit.Habit
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