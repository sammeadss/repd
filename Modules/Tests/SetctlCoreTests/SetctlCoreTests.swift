@testable import SetctlCore
import Testing

@Test func totalVolumeSumsRepsTimesWeight() {
    let sets = [(reps: 10, weight: 100.0), (reps: 5, weight: 200.0)]
    #expect(WorkoutMath.totalVolume(of: sets) == 2000)
}

@Test func totalVolumeOfNoSetsIsZero() {
    #expect(WorkoutMath.totalVolume(of: []) == 0)
}
