//
//  AppDatabase.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/21/26.
//

import Foundation
import GRDB

public struct AppDatabase {
    private let dbWriter: any DatabaseWriter

    init(_ dbWriter: some DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }

    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        #if DEBUG
            migrator.eraseDatabaseOnSchemaChange = true
        #endif

        migrator.registerMigration("v1: initial schema") { db in
            try db.create(table: "profile") { t in
                t.primaryKey("id", .text)
                t.column("handle", .text)
                t.column("units", .text).notNull()
                t.column("defaultRestS", .integer).notNull()
                t.column("createdAt", .datetime).notNull()
                t.column("updatedAt", .datetime).notNull()
            }
            try db.create(table: "exercise") { t in
                t.primaryKey("id", .text)
                t.column("name", .text).notNull()
                t.column("primaryMuscle", .text).notNull()
                t.column("equipment", .text).notNull()
                t.column("isCustom", .boolean).notNull()
                t.column("ownerId", .text)
                t.column("updatedAt", .datetime).notNull()
                t.column("deletedAt", .datetime)
            }
            try db.create(table: "workout") { t in
                t.primaryKey("id", .text)
                t.column("startedAt", .datetime).notNull()
                t.column("endedAt", .datetime)
                t.column("note", .text)
                t.column("createdAt", .datetime).notNull()
                t.column("updatedAt", .datetime).notNull()
                t.column("deletedAt", .datetime)
            }
            try db.create(table: "workoutExercise") { t in
                t.primaryKey("id", .text)
                t.belongsTo("workout", onDelete: .cascade).notNull()
                t.belongsTo("exercise").notNull()
                t.column("position", .integer).notNull()
                t.column("updatedAt", .datetime).notNull()
                t.column("deletedAt", .datetime)
            }
            try db.create(table: "setEntry") { t in
                t.primaryKey("id", .text)
                t.belongsTo("workoutExercise", onDelete: .cascade).notNull()
                t.column("position", .integer).notNull()
                t.column("reps", .integer).notNull()
                t.column("weight", .double).notNull()
                t.column("weightUnit", .text).notNull()
                t.column("rpe", .double)
                t.column("isWarmup", .boolean).notNull()
                t.column("isCompleted", .boolean).notNull()
                t.column("createdAt", .datetime).notNull()
                t.column("updatedAt", .datetime).notNull()
                t.column("deletedAt", .datetime)
            }
        }

        return migrator
    }

    func write<T>(_ updates: (Database) throws -> T) throws -> T {
        try dbWriter.write(updates)
    }

    func read<T>(_ value: (Database) throws -> T) throws -> T {
        try dbWriter.read(value)
    }

    public static func empty() throws -> AppDatabase {
        try AppDatabase(DatabaseQueue())
    }
}
