//
//  HomeView.swift
//  SetctlModules
//
//  Created by Samuel Meads on 7/23/26.
//

import SetctlDesignSystem
import SwiftUI

public struct HomeView: View {
    @State private var isSessionActive = false
    @State private var isSettingsPresented = false
    @AppStorage(StorageKey.scanlinesEnabled) private var isScanlinesEnabled = true

    public init() {}

    public var body: some View {
        NavigationStack {
            ZStack {
                Palette.black.ignoresSafeArea()

                VStack(spacing: Spacing.lg) {
                    Text("SETCTL")
                        .font(Typography.hero)
                        .foregroundStyle(Palette.green)

                    CornerFrame {
                        Button("Begin") {
                            isSessionActive = true
                        }
                        .font(Typography.title)
                        .foregroundStyle(Palette.green)
                    }
                }
            }
            .scanlines(isEnabled: isScanlinesEnabled)
            .toolbar {
                Button {
                    isSettingsPresented = true
                } label: {
                    Image(systemName: "gear")
                }
                .foregroundStyle(Palette.green)
            }
            .navigationDestination(isPresented: $isSessionActive) {
                ActiveSessionView()
            }
            .sheet(isPresented: $isSettingsPresented) {
                SettingsView()
            }
        }
    }
}

#Preview {
    HomeView()
}
