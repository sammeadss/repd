//
//  ActiveSessionView.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/23/26.
//

import RepdData
import RepdDesignSystem
import SwiftUI

struct ActiveSessionView: View {
    @Environment(AppModel.self) private var appModel
    @State private var model: ActiveSessionModel?
    @State private var showingPicker = false
    @State private var showingSummary = false

    var body: some View {
        ZStack {
            Palette.black.ignoresSafeArea()

            if let model {
                VStack(spacing: Spacing.md) {
                    Text("SESSION")
                        .font(Typography.title)
                        .foregroundStyle(Palette.green)

                    ForEach(model.exercises) { item in
                        SessionExerciseRow(item: item) { reps, weight in
                            model.addSet(to: item.id, reps: reps, weight: weight)
                        }
                    }

                    Button("+ Add Exercise") {
                        showingPicker = true
                    }
                    .font(Typography.body)
                    .foregroundStyle(Palette.green)

                    Button("END SESSION") {
                        model.endSession()
                        showingSummary = true
                    }
                    .font(Typography.body)
                    .foregroundStyle(Palette.green)
                }
                .sheet(isPresented: $showingPicker) {
                    ExercisePickerView { exercise in
                        model.addExercise(exercise)
                        showingPicker = false
                    }
                }
                .navigationDestination(isPresented: $showingSummary) {
                    SessionSummaryView(
                        duration: model.duration,
                        totalSets: model.totalSets,
                        totalVolume: model.totalVolume
                    )
                }
            }
        }
        .task {
            if model == nil {
                model = ActiveSessionModel(workoutRepository: appModel.workoutRepository)
            }
        }
    }
}
