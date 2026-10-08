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
        case transition
        case resolve
    }

    @State private var phase: Phase = .scramble
    @State private var isSkipped = false
    @State private var bloomIntensity: Double = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @AppStorage(StorageKey.hapticsEnabled) private var isHapticsEnabled = true

    private let hapticEngine = HapticEngine()
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
            TimelineView(.periodic(from: .now, by: 0.08)) { _ in
                Text(randomNoise())
                    .font(.system(size: figureFontSize, design: .monospaced))
                    .foregroundStyle(Palette.greenDim)
            }
        case .transition:
            let start = Date()
            TimelineView(.periodic(from: start, by: frameInterval)) { context in
                let elapsed = context.date.timeIntervalSince(start)
                let index = Int(elapsed / frameInterval)
                let frame = transitionFrames.isEmpty
                    ? ""
                    : transitionFrames[min(index, transitionFrames.count - 1)]
                Text(frame)
                    .font(.system(size: figureFontSize, design: .monospaced))
                    .foregroundStyle(Palette.green)
                    .bloom(intensity: bloomIntensity)
            }
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
        withAnimation(.easeInOut(duration: 0.8)) { phase = .transition }
        if isHapticsEnabled {
            hapticEngine.playFlexPump()
            withAnimation(.easeOut(duration: 0.15)) { bloomIntensity = 1 }
            withAnimation(.easeIn(duration: 0.65).delay(0.15)) { bloomIntensity = 0 }
        }

        try? await Task.sleep(for: .seconds(transitionHoldDuration))
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

    private let figureFontSize: CGFloat = 6
    private let figureColumns = 90
    private let figureRows = 108
    private let transitionHoldDuration: TimeInterval = 1.2
    private let transitionFrames = BootView.loadTransitionFrames()

    private var frameInterval: TimeInterval {
        transitionHoldDuration / Double(max(transitionFrames.count, 1))
    }

    private static func loadTransitionFrames() -> [String] {
        guard
            let url = Bundle.module.url(forResource: "frames", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let frames = try? JSONDecoder().decode([String].self, from: data)
        else { return [] }
        return frames
    }

    private func randomNoise() -> String {
        let glyphs = Array("01#$%&*@!?+=-:.")
        return (0 ..< figureRows)
            .map { _ in String((0 ..< figureColumns).map { _ in glyphs.randomElement() ?? "." }) }
            .joined(separator: "\n")
    }
}

#Preview {
    BootView(onFinished: {})
}
