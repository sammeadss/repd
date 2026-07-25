//
//  ActiveSessionModel.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/24/26.
//

import Foundation
import Observation
import RepdData

@Observable
final class ActiveSessionModel {
    private let workoutRepository: WorkoutRepository
    private(set) var workout: Workout
    private(set) var exercises: [WorkoutExerciseWithSets] = []

    init(workoutRepository: WorkoutRepository) {
        self.workoutRepository = workoutRepository
        let now = Date()
        workout = Workout(
            startedAt: now,
            endedAt: nil,
            note: nil,
            createdAt: now,
            updatedAt: now,
            deletedAt: nil
        )
    }

    func addExercise(_ exercise: Exercise) {
        let workoutExercise = WorkoutExercise(
            workoutId: workout.id,
            exerciseId: exercise.id,
            position: exercises.count,
            updatedAt: Date(),
            deletedAt: nil
        )

        exercises.append(WorkoutExerciseWithSets(workoutExercise: workoutExercise, sets: []))
    }
}
