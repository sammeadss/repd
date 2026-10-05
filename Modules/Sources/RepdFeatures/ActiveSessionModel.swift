//
//  ActiveSessionModel.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/24/26.
//

import Foundation
import Observation
import RepdCore
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

        let previousSets = (try? workoutRepository.fetchLastSets(for: exercise.id)) ?? []

        exercises.append(SessionExercise(
            exercise: exercise,
            previousSets: previousSets,
            workoutExercise: workoutExercise,
            sets: []
        ))
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

    func endSession() {
        let now = Date()
        workout.endedAt = now
        workout.updatedAt = now

        let details = WorkoutDetails(
            workout: workout,
            exercises: exercises.map { sessionExercise in
                WorkoutExerciseWithSets(
                    workoutExercise: sessionExercise.workoutExercise,
                    sets: sessionExercise.sets
                )
            }
        )

        do {
            try workoutRepository.save(details)
        } catch {
            print("Failed to save workout: \(error)")
        }
    }

    func deleteSet(from sessionExerciseId: String, setId: String) {
        guard let index = exercises.firstIndex(where: { $0.id == sessionExerciseId }) else { return }
        guard let setIndex = exercises[index].sets.firstIndex(where: { $0.id == setId }) else { return }

        exercises[index].sets.remove(at: setIndex)

        for newPosition in exercises[index].sets.indices {
            exercises[index].sets[newPosition].position = newPosition
        }
    }

    var totalSets: Int {
        exercises.flatMap(\.sets).count
    }

    var totalVolume: Double {
        WorkoutMath.totalVolume(of: exercises.flatMap(\.sets).map { (reps: $0.reps, weight: $0.weight) })
    }

    var duration: TimeInterval {
        guard let endedAt = workout.endedAt else { return 0 }
        return endedAt.timeIntervalSince(workout.startedAt)
    }
}

struct SessionExercise: Identifiable {
    let exercise: Exercise
    let previousSets: [SetEntry]
    var workoutExercise: WorkoutExercise
    var sets: [SetEntry]
    var id: String {
        workoutExercise.id
    }
}
