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

    var body: some View {
        ZStack {
            Palette.black.ignoresSafeArea()

            if let model {
                VStack(spacing: Spacing.md) {
                    Text("SESSION")
                        .font(Typography.title)
                        .foregroundStyle(Palette.green)

                    Text("Exercises: \(model.exercises.count)")
                        .font(Typography.body)
                        .foregroundStyle(Palette.greenDim)

                    Button("+ Add Exercise") {
                        showingPicker = true
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
            }
        }
        .task {
            if model == nil {
                model = ActiveSessionModel(workoutRepository: appModel.workoutRepository)
            }
        }
    }
}
