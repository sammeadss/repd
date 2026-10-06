//
//  SettingsView.swift
//  SetctlModules
//
//  Created by Samuel Meads on 10/6/26.
//

import SetctlData
import SetctlDesignSystem
import SwiftUI

struct SettingsView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Palette.black.ignoresSafeArea()

                content
            }
            .toolbar {
                Button("DONE") { dismiss() }
                    .foregroundStyle(Palette.green)
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch appModel.authState {
        case .guest:
            AuthView()
        case .signedIn:
            VStack(spacing: Spacing.lg) {
                Text("SETTINGS")
                    .font(Typography.title)
                    .foregroundStyle(Palette.green)

                Button("SIGN OUT") {
                    Task { try? await appModel.authRepository.signOut() }
                }
                .font(Typography.body)
                .foregroundStyle(Palette.greenDim)
            }
        }
    }
}

#Preview {
    SettingsView()
        // swiftlint:disable:next force_try
        .environment(AppModel(database: try! .empty(), supabaseClient: SupabaseConfig.makeClient()))
}
