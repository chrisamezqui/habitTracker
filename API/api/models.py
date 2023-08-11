from app import db

# class User(db.Model):
#     __tablename__ = "users_table"
#     id = db.Column(db.Integer, primary_key=True)
#     name = db.Column(db.String)
#     routines = relationship("Routine", back_populates="users")

# habit_routine_m2m = db.Table(
#     "habit_routine",
#     db.Column("habit_id", db.ForeignKey("habits_table.id"), primary_key=True),
#     db.Column("routine_id", db.ForeignKey("routines_table.id"), primary_key=True)
# )

class RoutineHabit(db.Model):
    __tablename__ = "routine_habit"
    habit_id = db.Column("habit_id", db.ForeignKey("habits_table.id"), primary_key=True)
    routine_id = db.Column("routine_id", db.ForeignKey("routines_table.id"), primary_key=True)
    index = db.Column(db.Integer)

    habit = db.relationship("Habit", back_populates= "routines") 
    routine = db.relationship("Routine", back_populates= "habits")

    def to_dict(self):
        return {
            "habit_id": self.habit_id,
            "routine_id": self.routine_id,
            "index": self.index
        }


class Routine(db.Model):
    __tablename__ = "routines_table"
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String)
    # habits = db.relationship(
    #     "Habit", secondary=habit_routine_m2m, back_populates="routines"
    # )
    # TODO: order these by index
    habits = db.relationship(
        "RoutineHabit", back_populates="routine", order_by="RoutineHabit.index"
    )
    # user_id = db.Column(db.Integer, ForeignKey("users_table.id"))
    # user = relationship("User", back_populates="routines")
    def to_dict(self):
        return {
            "id": self.id,
            "title": self.title,
            "habits": self.habits or []
        }

class Habit(db.Model):
    __tablename__ = "habits_table"
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String)
    description = db.Column(db.String)
    last_completed = db.Column(db.Date)
    streak_count = db.Column(db.Integer, default=0)
    # routines = db.relationship(
    #     "Routine", secondary=habit_routine_m2m, back_populates="habits"
    # )
    routines = db.relationship(
        "RoutineHabit", back_populates="habit"
    )
    def to_dict(self):
        return {
            "id": self.id,
            "last_completed": str(self.last_completed.strftime('%d/%m/%Y')) if self.last_completed else None,
            "title": self.title,
            "description": self.description,
            "streak_count": self.streak_count,
            "routines": self.routines or []
        }
