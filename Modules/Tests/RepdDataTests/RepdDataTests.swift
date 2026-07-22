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

@Test func savesAndFetchesWorkoutDetails() throws {
    let database = try AppDatabase.empty()
    let repository = WorkoutRepository(database: database)
    let date = Date(timeIntervalSince1970: 1_000_000)

    let exercise = Exercise(
        name: "Squat",
        primaryMuscle: "legs",
        isBodyweight: true,
        isCustom: false,
        ownerId: nil,
        updatedAt: date,
        deletedAt: nil
    )
    try database.write { db in try exercise.save(db) }

    let workout = Workout(
        startedAt: date, endedAt: nil, note: "leg day",
        createdAt: date, updatedAt: date, deletedAt: nil
    )
    let workoutExercise = WorkoutExercise(
        workoutId: workout.id, exerciseId: exercise.id,
        position: 0, updatedAt: date, deletedAt: nil
    )
    let set1 = SetEntry(
        workoutExerciseId: workoutExercise.id, position: 0,
        reps: 5, weight: 100, weightUnit: "kg", rpe: nil,
        isWarmup: false, isCompleted: true,
        createdAt: date, updatedAt: date, deletedAt: nil
    )
    let set2 = SetEntry(
        workoutExerciseId: workoutExercise.id, position: 1,
        reps: 5, weight: 105, weightUnit: "kg", rpe: 8,
        isWarmup: false, isCompleted: true,
        createdAt: date, updatedAt: date, deletedAt: nil
    )

    let details = WorkoutDetails(
        workout: workout,
        exercises: [
            WorkoutExerciseWithSets(workoutExercise: workoutExercise, sets: [set1, set2]),
        ]
    )

    try repository.save(details)
    let fetched = try repository.fetchDetails(id: workout.id)

    #expect(fetched == details)
}

@Test func seedsExerciseCatalog() throws {
    let database = try AppDatabase.empty()

    try database.read { db in
        let count = try Exercise.fetchCount(db)
        #expect(count == 8)

        let pullUp = try Exercise.fetchOne(db, id: "00000000-0000-0000-0000-000000000006")
        #expect(pullUp?.name == "Pull-Up")
        #expect(pullUp?.isBodyweight == true)
    }
}
