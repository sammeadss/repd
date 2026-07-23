//
//  RepdApp.swift
//  Repd
//
//  Created by Samuel Meads on 6/19/26.
//

import RepdData
import RepdFeatures
import SwiftUI

@main
struct RepdApp: App {
    @State private var appModel: AppModel

    init() {
        do {
            let database = try AppDatabase.makeShared()
            _appModel = State(initialValue: AppModel(database: database))
        } catch {
            fatalError("Failed to initialize the database: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(appModel)
        }
    }
}
