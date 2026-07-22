//
//  WorkoutRepository.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/22/26.
//

import Foundation
import GRDB

public struct WorkoutRepository {
    private let database: AppDatabase

    public init(database: AppDatabase) {
        self.database = database
    }

    public func save(_ workout: Workout) throws {
        try database.write { db in
            try workout.save(db)
        }
    }

    public func fetchWorkout(id: String) throws -> Workout? {
        try database.read { db in
            try Workout.fetchOne(db, id: id)
        }
    }

    public func save(_ details: WorkoutDetails) throws {
        try database.write { db in
            try details.workout.save(db)
            for exercise in details.exercises {
                try exercise.workoutExercise.save(db)
                for set in exercise.sets {
                    try set.save(db)
                }
            }
        }
    }

    public func fetchDetails(id: String) throws -> WorkoutDetails? {
        try database.read { db in
            guard let workout = try Workout.fetchOne(db, id: id) else {
                return nil
            }

            let workoutExercises = try WorkoutExercise
                .filter(Column("workoutId") == id)
                .order(Column("position"))
                .fetchAll(db)

            var exercises: [WorkoutExerciseWithSets] = []
            for we in workoutExercises {
                let sets = try SetEntry
                    .filter(Column("workoutExerciseId") == we.id)
                    .order(Column("position"))
                    .fetchAll(db)
                exercises.append(WorkoutExerciseWithSets(workoutExercise: we, sets: sets))
            }

            return WorkoutDetails(workout: workout, exercises: exercises)
        }
    }
}
