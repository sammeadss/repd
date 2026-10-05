import Foundation
@testable import SetctlData
@testable import SetctlFeatures
import Testing

@Test func deleteSetRenumbersRemainingSets() throws {
    let database = try AppDatabase.empty()
    let repository = WorkoutRepository(database: database)
    let model = ActiveSessionModel(workoutRepository: repository)

    let exercise = Exercise(
        name: "Bench Press", primaryMuscle: "chest",
        isBodyweight: false, isCustom: false, ownerId: nil,
        updatedAt: Date(), deletedAt: nil
    )
    model.addExercise(exercise)
    model.addSet(to: model.exercises[0].id, reps: 5, weight: 100)
    model.addSet(to: model.exercises[0].id, reps: 5, weight: 105)
    model.addSet(to: model.exercises[0].id, reps: 5, weight: 110)

    let sessionExerciseId = model.exercises[0].id
    let middleSetId = model.exercises[0].sets[1].id

    model.deleteSet(from: sessionExerciseId, setId: middleSetId)

    let remaining = model.exercises[0].sets
    #expect(remaining.count == 2)
    #expect(!remaining.contains { $0.id == middleSetId })
    #expect(remaining.map(\.position) == [0, 1])
}
