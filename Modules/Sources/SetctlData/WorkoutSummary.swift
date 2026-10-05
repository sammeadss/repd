//
//  WorkoutSummary.swift
//  SetctlModules
//
//  Created by Samuel Meads on 10/5/26.
//

import Foundation

public struct WorkoutSummary: Identifiable, Equatable {
    public var id: String
    public var startedAt: Date
    public var duration: TimeInterval
    public var totalVolume: Double

    public init(
        id: String,
        startedAt: Date,
        duration: TimeInterval,
        totalVolume: Double
    ) {
        self.id = id
        self.startedAt = startedAt
        self.duration = duration
        self.totalVolume = totalVolume
    }
}
