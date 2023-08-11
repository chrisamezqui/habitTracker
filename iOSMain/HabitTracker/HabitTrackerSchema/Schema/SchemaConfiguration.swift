// @generated
// This file was automatically generated and can be edited to
// provide custom configuration for a generated GraphQL schema.
//
// Any changes to this file will not be overwritten by future
// code generation execution.

import Apollo

enum SchemaConfiguration: Apollo.SchemaConfiguration {
    static func cacheKeyInfo(for type: Object, object: ObjectData) -> CacheKeyInfo? {
        switch type {
        case HabitTrackerSchema.Objects.Habit:
            return try? CacheKeyInfo(jsonValue: object["id"])
        default: return nil
        }
    }
}
