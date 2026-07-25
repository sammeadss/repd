//
//  WorkoutExercise.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/22/26.
//

import Foundation
import GRDB

public struct WorkoutExercise: Codable, Identifiable, Equatable, FetchableRecord, PersistableRecord {
    public var id: String = UUID().uuidString
    public var workoutId: String
    public var exerciseId: String
    public var position: Int
    public var updatedAt: Date
    public var deletedAt: Date?

    public init(
        id: String = UUID().uuidString,
        workoutId: String,
        exerciseId: String,
        position: Int,
        updatedAt: Date,
        deletedAt: Date? = nil
    ) {
        self.id = id
        self.workoutId = workoutId
        self.exerciseId = exerciseId
        self.position = position
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
