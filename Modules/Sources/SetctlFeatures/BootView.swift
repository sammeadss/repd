//
//  BootView.swift
//  SetctlModules
//
//  Created by Samuel Meads on 10/7/26.
//

import SetctlDesignSystem
import SwiftUI

public struct BootView: View {
    @State private var bootStart = Date()
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
        }
        .contentShape(Rectangle())
        .onTapGesture { skip() }
        .task { await runSequence() }
    }

    private var content: some View {
        TimelineView(.periodic(from: bootStart, by: tickInterval)) { context in
            let elapsed = context.date.timeIntervalSince(bootStart)
            Text(currentFrame(at: elapsed))
                .font(.system(size: figureFontSize, design: .monospaced))
                .foregroundStyle(elapsed < scrambleDuration ? Palette.greenDim : Palette.green)
                .bloom(intensity: bloomIntensity)
        }
    }

    private func currentFrame(at elapsed: TimeInterval) -> String {
        if elapsed < scrambleDuration {
            return randomNoise()
        }

        let sweepElapsed = elapsed - scrambleDuration
        if sweepElapsed < sweepDuration {
            let progress = sweepElapsed / sweepDuration
            return sweepReveal(progress: progress, target: transitionFrames.first ?? "")
        }

        let transitionElapsed = sweepElapsed - sweepDuration
        if transitionElapsed < transitionHoldDuration {
            guard !transitionFrames.isEmpty else { return "" }
            let index = Int(transitionElapsed / frameInterval)
            return transitionFrames[min(index, transitionFrames.count - 1)]
        }

        return resolveFrame
    }

    private func runSequence() async {
        guard !reduceMotion else {
            finish()
            return
        }

        try? await Task.sleep(for: .seconds(scrambleDuration + sweepDuration))
        guard !isSkipped else { return }
        if isHapticsEnabled {
            hapticEngine.playFlexPump()
            withAnimation(.easeOut(duration: 0.15)) { bloomIntensity = 1 }
            withAnimation(.easeIn(duration: 0.65).delay(0.15)) { bloomIntensity = 0 }
        }

        try? await Task.sleep(for: .seconds(transitionHoldDuration + resolveHoldDuration))
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
    private let figureRows = 115
    private let tickInterval: TimeInterval = 0.08
    private let scrambleDuration: TimeInterval = 1.2
    private let transitionHoldDuration: TimeInterval = 1.2
    private let resolveHoldDuration: TimeInterval = 1.0
    private let sweepDuration: TimeInterval = 0.7
    private let transitionFrames = BootView.loadTransitionFrames()
    private let resolveFrame = BootView.loadResolveFrame()

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

    private static func loadResolveFrame() -> String {
        guard
            let url = Bundle.module.url(forResource: "setctl_resolve", withExtension: "txt"),
            let text = try? String(contentsOf: url, encoding: .utf8)
        else { return "" }
        return text
    }

    private static let noiseGlyphs = Array("01#$%&*@!?+=-:.")

    private func randomNoise() -> String {
        (0 ..< figureRows)
            .map { _ in String((0 ..< figureColumns).map { _ in BootView.noiseGlyphs.randomElement() ?? "." }) }
            .joined(separator: "\n")
    }

    private func sweepReveal(progress: Double, target: String) -> String {
        guard !target.isEmpty else { return randomNoise() }
        let targetLines = target.split(separator: "\n", omittingEmptySubsequences: false)
        let revealedRows = Int(Double(targetLines.count) * progress)
        return targetLines.enumerated().map { index, line in
            index < revealedRows
                ? String(line)
                : String((0 ..< line.count).map { _ in BootView.noiseGlyphs.randomElement() ?? "." })
        }.joined(separator: "\n")
    }
}

#Preview {
    BootView(onFinished: {})
}
