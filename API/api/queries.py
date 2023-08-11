from ariadne import convert_kwargs_to_snake_case
from .models import Habit, Routine, RoutineHabit
from datetime import date

def get_habits_resolver(obj, info):
    try:
        habits = [habit.to_dict() for habit in Habit.query.all()]
        for habit in habits:
            routines = []
            for routine_habit in habit["routines"]:
                routine = Routine.query.get(routine_habit.routine_id)
                if routine:
                    routines.append(routine)
            habit["routines"] = routines
            habit["is_complete"] = date.today().strftime('%d/%m/%Y') == habit["last_completed"]
        payload = {
            "success": True,
            "habits": habits
        }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    print(payload)
    return payload

def get_unassigned_habits_resolver(obj, info, routine_id):
    try:
        habits = [habit.to_dict() for habit in Habit.query.all()]
        for habit in habits:
            routines = []
            for routine_habit in habit["routines"]:
                routine = Routine.query.get(routine_habit.routine_id)
                if routine and routine["id"] != routine_id:
                    routines.append(routine)
            habit["routines"] = routines
            habit["is_complete"] = date.today().strftime('%d/%m/%Y') == habit["last_completed"]
        payload = {
            "success": True,
            "habits": habits
        }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    print(payload)
    return payload

def get_routines_resolver(obj, info):
    try:
        routines = [routines.to_dict() for routines in Routine.query.all()]
        for routine in routines:
            habits = []
            for routine_habit in routine["habits"]:
                habit = Habit.query.get(routine_habit.habit_id)
                if habit:
                    habits.append(habit)
            routine["habits"] = habits

        payload = {
            "success": True,
            "routines": routines
        }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    print(payload)
    return payload
