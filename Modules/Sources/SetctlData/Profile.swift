//
//  Profile.swift
//  SetctlModules
//
//  Created by Samuel Meads on 10/6/26.
//

import Foundation
import GRDB

public struct Profile: Codable, Identifiable, FetchableRecord, PersistableRecord {
    public var id: String = UUID().uuidString
    public var units: String
    public var createdAt: Date
    public var updatedAt: Date
}
