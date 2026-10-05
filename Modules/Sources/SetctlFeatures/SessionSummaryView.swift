//
//  SessionSummaryView.swift
//  SetctlModules
//
//  Created by Samuel Meads on 8/5/26.
//

import SetctlDesignSystem
import SwiftUI

struct SessionSummaryView: View {
    let duration: TimeInterval
    let totalSets: Int
    let totalVolume: Double

    var body: some View {
        ZStack {
            Palette.black.ignoresSafeArea()

            VStack(spacing: Spacing.md) {
                Text("DONE")
                    .font(Typography.title)
                    .foregroundStyle(Palette.green)

                Text("\(Int(duration) / 60)min \(Int(duration) % 60)s")
                    .font(Typography.body)
                    .foregroundStyle(Palette.greenDim)

                Text("\(totalSets) sets")
                    .font(Typography.body)
                    .foregroundStyle(Palette.greenDim)

                Text("\(totalVolume, specifier: "%.1f")kg total")
                    .font(Typography.body)
                    .foregroundStyle(Palette.greenDim)
            }
        }
    }
}
