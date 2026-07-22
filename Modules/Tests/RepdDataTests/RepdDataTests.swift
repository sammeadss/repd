@testable import RepdData
import Testing

@Test func migrationRuns() throws {
    _ = try AppDatabase.empty()
}
