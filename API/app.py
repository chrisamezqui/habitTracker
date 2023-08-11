from api import app, db
from ariadne import load_schema_from_path, make_executable_schema, \
    graphql_sync, snake_case_fallback_resolvers, ObjectType
from flask import request, jsonify, render_template
from api.queries import get_habits_resolver, get_routines_resolver, get_unassigned_habits_resolver
from api.mutations import create_habit_resolver, create_routine_resolver, \
    add_habit_to_routine_resolver, update_habit_resolver, update_routine_resolver, \
    delete_habit_resolver, complete_habit_resolver, remove_habit_from_routine_resolver

query = ObjectType("Query")
mutation = ObjectType("Mutation")
query.set_field("getHabits", get_habits_resolver)
query.set_field("getRoutines", get_routines_resolver)
query.set_field("getUnassignedRoutines", get_unassigned_habits_resolver)
mutation.set_field("createHabit", create_habit_resolver)
mutation.set_field("createRoutine", create_routine_resolver)
mutation.set_field("addHabitToRoutine", add_habit_to_routine_resolver)
mutation.set_field("updateHabit", update_habit_resolver)
mutation.set_field("updateRoutine", update_routine_resolver)
mutation.set_field("deleteHabit", delete_habit_resolver)
mutation.set_field("completeHabit", complete_habit_resolver)
mutation.set_field("removeHabitFromRoutine", remove_habit_from_routine_resolver)

type_defs = load_schema_from_path("schema.graphql")
schema = make_executable_schema(
    type_defs, query, mutation, snake_case_fallback_resolvers
)

@app.route("/graphql", methods=["GET"])
def graphql_playground():
    print("\nGET CALLED\n")
    return render_template("sandbox.html")

@app.route("/graphql", methods=["POST"])
def graphql_server():
    print("\nPOST CALLED\n")
    data = request.get_json()
    success, result = graphql_sync(
        schema,
        data,
        context_value=request,
        debug=app.debug
    )
    status_code = 200 if success else 400
    # print(jsonify(result))
    return jsonify(result), status_code