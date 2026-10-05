//
//  WorkoutDetails.swift
//  SetctlModules
//
//  Created by Samuel Meads on 7/22/26.
//

import Foundation

public struct WorkoutDetails: Equatable {
    public var workout: Workout
    public var exercises: [WorkoutExerciseWithSets]

    public init(
        workout: Workout,
        exercises: [WorkoutExerciseWithSets]
    ) {
        self.workout = workout
        self.exercises = exercises
    }
}

public struct WorkoutExerciseWithSets: Equatable {
    public var workoutExercise: WorkoutExercise
    public var sets: [SetEntry]

    public init(
        workoutExercise: WorkoutExercise,
        sets: [SetEntry]
    ) {
        self.workoutExercise = workoutExercise
        self.sets = sets
    }
}
