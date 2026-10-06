//
//  AppModel.swift
//  SetctlModules
//
//  Created by Samuel Meads on 7/23/26.
//

import Observation
import SetctlData
import Supabase

@MainActor
@Observable
public final class AppModel {
    public let exerciseRepository: ExerciseRepository
    public let workoutRepository: WorkoutRepository
    public let authRepository: AuthRepository
    public private(set) var authState: AuthState = .guest

    public init(database: AppDatabase, supabaseClient: SupabaseClient) {
        exerciseRepository = ExerciseRepository(database: database)
        workoutRepository = WorkoutRepository(database: database)
        authRepository = AuthRepository(client: supabaseClient)

        Task {
            await refreshAuthState()
        }
    }

    private func refreshAuthState() async {
        if let userId = await authRepository.currentUserId() {
            authState = .signedIn(userId: userId)
        } else {
            authState = .guest
        }
    }
}
