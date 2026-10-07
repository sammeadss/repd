//
//  BootView.swift
//  SetctlModules
//
//  Created by Samuel Meads on 10/7/26.
//

import SetctlDesignSystem
import SwiftUI

public struct BootView: View {
    private enum Phase {
        case scramble
        case decode
        case transition
        case resolve
    }

    @State private var phase: Phase = .scramble
    @State private var isSkipped = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    let onFinished: () -> Void

    public init(onFinished: @escaping () -> Void) {
        self.onFinished = onFinished
    }

    public var body: some View {
        ZStack {
            Palette.black.ignoresSafeArea()
            content
                .transition(.opacity)
        }
        .contentShape(Rectangle())
        .onTapGesture { skip() }
        .task { await runSequence() }
    }

    @ViewBuilder
    private var content: some View {
        switch phase {
        case .scramble:
            Text("# $ % & * @ ! ?")
                .font(Typography.title)
                .foregroundStyle(Palette.greenDim)
        case .decode:
            Text(figureA)
                .font(Typography.body)
                .foregroundStyle(Palette.green)
        case .transition:
            Text(figureB)
                .font(Typography.body)
                .foregroundStyle(Palette.green)
        case .resolve:
            Text("SETCTL")
                .font(Typography.hero)
                .foregroundStyle(Palette.green)
        }
    }

    private func runSequence() async {
        guard !reduceMotion else {
            finish()
            return
        }

        try? await Task.sleep(for: .seconds(1.2))
        guard !isSkipped else { return }
        withAnimation(.easeInOut(duration: 0.6)) { phase = .decode }

        try? await Task.sleep(for: .seconds(1.2))
        guard !isSkipped else { return }
        withAnimation(.easeInOut(duration: 0.8)) { phase = .transition }

        try? await Task.sleep(for: .seconds(1.2))
        guard !isSkipped else { return }
        withAnimation(.easeInOut(duration: 0.6)) { phase = .resolve }

        try? await Task.sleep(for: .seconds(1))
        guard !isSkipped else { return }
        finish()
    }

    private func skip() {
        isSkipped = true
        finish()
    }

    private func finish() {
        onFinished()
    }

    private let figureA = #"""
      o
     /|\
     / \
    """#

    private let figureB = #"""
     \o/
      |
     / \
    """#
}

#Preview {
    BootView(onFinished: {})
}
