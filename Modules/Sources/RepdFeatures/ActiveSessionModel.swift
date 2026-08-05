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
    private(set) var exercises: [SessionExercise] = []

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

        exercises.append(SessionExercise(exercise: exercise, workoutExercise: workoutExercise, sets: []))
    }

    func addSet(to sessionExerciseId: String, reps: Int, weight: Double) {
        guard let index = exercises.firstIndex(where: { $0.id == sessionExerciseId }) else { return }

        let now = Date()
        let set = SetEntry(
            workoutExerciseId: exercises[index].workoutExercise.id,
            position: exercises[index].sets.count,
            reps: reps,
            weight: weight,
            weightUnit: "kg",
            isWarmup: false,
            isCompleted: true,
            createdAt: now,
            updatedAt: now
        )

        exercises[index].sets.append(set)
    }
}

struct SessionExercise: Identifiable {
    let exercise: Exercise
    var workoutExercise: WorkoutExercise
    var sets: [SetEntry]
    var id: String {
        workoutExercise.id
    }
}
