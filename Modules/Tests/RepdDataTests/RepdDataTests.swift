import Foundation
@testable import RepdData
import Testing

@Test func migrationRuns() throws {
    _ = try AppDatabase.empty()
}

@Test func savesAndFetchesWorkout() throws {
    let database = try AppDatabase.empty()
    let repository = WorkoutRepository(database: database)

    let date = Date(timeIntervalSince1970: 1_000_000)
    let workout = Workout(
        startedAt: date,
        endedAt: nil,
        note: "leg day",
        createdAt: date,
        updatedAt: date,
        deletedAt: nil
    )
    try repository.save(workout)

    let fetched = try repository.fetchWorkout(id: workout.id)
    #expect(fetched == workout)
}
