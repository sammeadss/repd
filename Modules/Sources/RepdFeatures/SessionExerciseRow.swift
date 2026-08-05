//
//  SessionExerciseRow.swift
//  RepdModules
//
//  Created by Samuel Meads on 8/5/26.
//

import RepdData
import RepdDesignSystem
import SwiftUI

struct SessionExerciseRow: View {
    let item: SessionExercise
    let onAddSet: (Int, Double) -> Void

    @State private var reps = 8
    @State private var weight = 20.0

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(item.exercise.name)
                .font(Typography.body)
                .foregroundStyle(Palette.green)

            ForEach(item.sets) { set in
                Text("\(set.reps) x \(set.weight, specifier: "%.1f")kg")
                    .font(Typography.label)
                    .foregroundStyle(Palette.greenDim)
            }

            Stepper("\(reps) reps", value: $reps, in: 1 ... 50)
                .font(Typography.label)
                .foregroundStyle(Palette.green)

            Stepper("\(weight, specifier: "%.1f") kg", value: $weight, in: 0 ... 500, step: 2.5)
                .font(Typography.label)
                .foregroundStyle(Palette.green)

            Button("+ ADD SET") {
                onAddSet(reps, weight)
            }
            .font(Typography.label)
            .foregroundStyle(Palette.green)
        }
    }
}
