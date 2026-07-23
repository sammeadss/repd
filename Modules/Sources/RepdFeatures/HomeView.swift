//
//  HomeView.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/23/26.
//

import RepdDesignSystem
import SwiftUI

public struct HomeView: View {
    @State private var isSessionActive = false

    public init() {}

    public var body: some View {
        NavigationStack {
            ZStack {
                Palette.black.ignoresSafeArea()

                VStack(spacing: Spacing.lg) {
                    Text("REPD")
                        .font(Typography.hero)
                        .foregroundStyle(Palette.green)

                    Button("Begin_") {
                        isSessionActive = true
                    }
                    .font(Typography.title)
                    .foregroundStyle(Palette.green)
                }
            }
            .navigationDestination(isPresented: $isSessionActive) {
                ActiveSessionView()
            }
        }
    }
}

#Preview {
    HomeView()
}
