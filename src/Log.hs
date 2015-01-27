module Log where

type Rep      = Integer
type Weight   = Double
type Name     = String


data LogEntry = Exercise     Name [(Rep, Weight)]
              | RepExercise  Name [Rep]
              deriving (Show)


type ExerciseLog = [LogEntry]

data Workout = MondayWorkout    Name ExerciseLog
             | TuesdayWorkout   Name ExerciseLog
             | WednesdayWorkout Name ExerciseLog
             | ThursdayWorkout  Name ExerciseLog
             | FridayWorkout    Name ExerciseLog
             | SaturdayWorkout  Name ExerciseLog
             | SundayWorkout    Name ExerciseLog
             deriving (Show)
