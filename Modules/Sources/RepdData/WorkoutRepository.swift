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
}
