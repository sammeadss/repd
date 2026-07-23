//
//  ExerciseRepository.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/23/26.
//

import Foundation
import GRDB

public struct ExerciseRepository {
    private let database: AppDatabase

    public init(database: AppDatabase) {
        self.database = database
    }

    public func fetchAllExercises() throws -> [Exercise] {
        try database.read { db in
            try Exercise
                .filter(Column("deletedAt") == nil)
                .order(Column("name"))
                .fetchAll(db)
        }
    }
}
