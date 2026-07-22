//
//  SetEntry.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/22/26.
//

import Foundation
import GRDB

public struct SetEntry: Codable, Identifiable, Equatable, FetchableRecord, PersistableRecord {
    public var id: String = UUID().uuidString
    public var workoutExerciseId: String
    public var position: Int
    public var reps: Int
    public var weight: Double
    public var weightUnit: String
    public var rpe: Double?
    public var isWarmup: Bool
    public var isCompleted: Bool
    public var createdAt: Date
    public var updatedAt: Date
    public var deletedAt: Date?
}
