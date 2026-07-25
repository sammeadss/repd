//
//  Workout.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/22/26.
//

import Foundation
import GRDB

public struct Workout: Codable, Identifiable, Equatable, FetchableRecord, PersistableRecord {
    public var id: String = UUID().uuidString
    public var startedAt: Date
    public var endedAt: Date?
    public var note: String?
    public var createdAt: Date
    public var updatedAt: Date
    public var deletedAt: Date?

    public init(
        id: String = UUID().uuidString,
        startedAt: Date,
        endedAt: Date? = nil,
        note: String? = nil,
        createdAt: Date,
        updatedAt: Date,
        deletedAt: Date? = nil
    ) {
        self.id = id
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.note = note
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
