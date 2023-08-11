from datetime import date
from ariadne import convert_kwargs_to_snake_case
from api import db
from api.models import Habit, Routine, RoutineHabit
from datetime import date, timedelta

@convert_kwargs_to_snake_case
def create_habit_resolver(obj, info, title, description=None):
    try:
        # today = date.today()
        habit = Habit(
            title=title, description=description, streak_count=0
        )
        db.session.add(habit)
        db.session.commit()
        payload = {
            "success": True,
            "habits": [habit.to_dict()]
        }
    except Exception as error: 
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    return payload

def create_routine_resolver(obj, info, title):
    try:
        routine = Routine(
            title=title
            )
        db.session.add(routine)
        db.session.commit()
        payload = {
            "success": True,
            "routines": [routine.to_dict()]
        }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    return payload

@convert_kwargs_to_snake_case
def update_habit_resolver(obj, info, id, title=None, description=None, last_completed=None):
    try:
        # today = date.today()
        habit = Habit.query.get(id)
        if habit:
            if title:
                habit.title = title
            if description:
                habit.description = description
            # if last_completed:
            #     habit.last_completed = last_completed
        db.session.add(habit)
        db.session.commit()
        payload = {
            "success": True,
            "habits": [habit.to_dict()]
        }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    return payload

def update_routine_resolver(obj, info, id, title=None):
    try:
        routine = Routine.query.get(id)
        if routine:
            if title:
                routine.title = title
        db.session.add(routine)
        db.session.commit()
        payload = {
                "success": True,
                "routines": [routine.to_dict()]
            }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    return payload


def add_habit_to_routine_resolver(obj, info, id, habit_id=None, index=None):
    print("add_habit_to_routine_resolver")
    try:
        routine = Routine.query.get(id)
        print("routine: ",routine)
        if routine:
            # if habit_id and habit_id not in routine.habits:
            #     habit = Habit.query.get(habit_id)
            #     routine.habits.append(habit)
            if habit_id:
                routine_habit = RoutineHabit(habit_id=habit_id, routine_id=id, index=index)
                routine.habits.append(routine_habit)

        db.session.add(routine)
        db.session.commit()
        payload = {
            "success": True,
            "routines": [routine.to_dict()]
        }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    print(payload)
    return payload

def delete_habit_resolver(obj, info, id):
    print('delete_habit_resolver')
    try:
        Habit.query.filter(Habit.id ==id).delete()
        db.session.commit()
        payload = {
            "success": True,
            "habits": [Habit(id=id)]
        }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    print(payload)
    return payload

def complete_habit_resolver(obj, info, id):
    print('complete_habit_resolver')
    today = date.today()
    try:
        habit = Habit.query.get(id)

        if habit:
            last_completed = habit.last_completed
            # if last_completed is None or last_completed != today:
            habit.last_completed = today
            # if last_completed and today
            habit.streak_count = habit.streak_count + 1 if habit.streak_count is not None else 1
            db.session.add(habit)
            db.session.commit()
            payload = {
                "success": True,
                "habits": [habit.to_dict()]
            }
        else:
            payload = {
                "success": False,
                "habits": [None]
            }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    print(payload)
    return payload

def remove_habit_from_routine_resolver(obj, info, habit_id, routine_id):
    print("remove_habit_from_routine_resolver", habit_id, routine_id)
    try:
        # RoutineHabit.query.filter(RoutineHabit.habit_id==habit_id, RoutineHabit.routine_id==routine_id).delete()
        #TODO: fix this later https://stackoverflow.com/questions/23699651/dependency-rule-tried-to-blank-out-primary-key-in-sqlalchemy-when-foreign-key-c
        routine = Routine.query.get(routine_id)
        habits = routine.habits
        #should already be an in-order traversal
        index = 0
        new_habits = []
        for routine_habit in habits:
            if routine_habit.habit_id != int(habit_id):
                print(type(routine_habit.habit_id) , type(habit_id))
                routine_habit.index = index
                new_habits.append(routine_habit)
                index += 1
        routine.habits = new_habits
        print(routine.habits)
        print(new_habits)

        db.session.add(routine)
        db.session.commit()
        payload = {
            "success": True,
            "routines": []
        }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    print(payload)
    return payload


