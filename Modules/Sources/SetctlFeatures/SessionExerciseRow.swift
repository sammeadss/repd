//
//  SessionExerciseRow.swift
//  SetctlModules
//
//  Created by Samuel Meads on 8/5/26.
//

import SetctlData
import SetctlDesignSystem
import SwiftUI

struct SessionExerciseRow: View {
    let item: SessionExercise
    let onAddSet: (Int, Double) -> Void
    let onDeleteSet: (String) -> Void
    let onMoveSets: (IndexSet, Int) -> Void

    @State private var reps: Int
    @State private var weight: Double

    init(
        item: SessionExercise,
        onAddSet: @escaping (Int, Double) -> Void,
        onDeleteSet: @escaping (String) -> Void,
        onMoveSets: @escaping (IndexSet, Int) -> Void
    ) {
        self.item = item
        self.onAddSet = onAddSet
        self.onDeleteSet = onDeleteSet
        self.onMoveSets = onMoveSets
        _reps = State(initialValue: item.previousSets.first?.reps ?? 8)
        _weight = State(initialValue: item.previousSets.first?.weight ?? 20.0)
    }

    private var lastWorkoutSummary: String {
        "LAST: " + item.previousSets
            .map { "\($0.reps)×\($0.weight.formatted())" }
            .joined(separator: ", ")
    }

    var body: some View {
        Text(item.exercise.name)
            .font(Typography.body)
            .foregroundStyle(Palette.green)

        if !item.previousSets.isEmpty {
            Text(lastWorkoutSummary)
                .font(Typography.label)
                .foregroundStyle(Palette.greenDim)
        }

        ForEach(item.sets) { set in
            Text("\(set.reps) x \(set.weight, specifier: "%.1f")kg")
                .font(Typography.label)
                .foregroundStyle(Palette.greenDim)
        }
        .onDelete { offsets in
            for index in offsets {
                onDeleteSet(item.sets[index].id)
            }
        }
        .onMove { source, destination in
            onMoveSets(source, destination)
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
