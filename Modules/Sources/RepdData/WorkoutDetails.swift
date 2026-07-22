//
//  WorkoutDetails.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/22/26.
//

import Foundation

public struct WorkoutDetails: Equatable {
    public var workout: Workout
    public var exercises: [WorkoutExerciseWithSets]
}

public struct WorkoutExerciseWithSets: Equatable {
    public var workoutExercise: WorkoutExercise
    public var sets: [SetEntry]
}
