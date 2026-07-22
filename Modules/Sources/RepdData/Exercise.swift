//
//  Exercise.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/22/26.
//

import Foundation
import GRDB

public struct Exercise: Codable, Identifiable, FetchableRecord, PersistableRecord {
    public var id: String = UUID().uuidString
    public var name: String
    public var primaryMuscle: String
    public var equipment: String
    public var isCustom: Bool
    public var ownerId: String?
    public var updatedAt: Date
    public var deletedAt: Date?
}
