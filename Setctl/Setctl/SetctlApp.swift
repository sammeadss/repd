//
//  SetctlApp.swift
//  Setctl
//
//  Created by Samuel Meads on 6/19/26.
//

import SetctlData
import SetctlDesignSystem
import SetctlFeatures
import SwiftUI

@main
struct SetctlApp: App {
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
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    }
            }
            .tint(Palette.green)
            .environment(appModel)
        }
    }
}
