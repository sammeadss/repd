//
//  AppModel.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/23/26.
//

import Observation
import RepdData

@Observable
public final class AppModel {
    public let exerciseRepository: ExerciseRepository
    public let workoutRepository: WorkoutRepository

    public init(database: AppDatabase) {
        exerciseRepository = ExerciseRepository(database: database)
        workoutRepository = WorkoutRepository(database: database)
    }
}
