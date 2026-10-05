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
                VStack(spacing: 0) {
                    Text("SESSION")
                        .font(Typography.title)
                        .foregroundStyle(Palette.green)
                        .padding(.top, Spacing.md)

                    List {
                        ForEach(model.exercises) { item in
                            Section {
                                SessionExerciseRow(item: item) { reps, weight in
                                    model.addSet(to: item.id, reps: reps, weight: weight)
                                } onDeleteSet: { setId in
                                    model.deleteSet(from: item.id, setId: setId)
                                }
                                .listRowBackground(Color.clear)
                            }
                        }

                        Section {
                            Button("+ Add Exercise") {
                                showingPicker = true
                            }
                            .font(Typography.body)
                            .foregroundStyle(Palette.green)
                            .listRowBackground(Color.clear)

                            Button("END SESSION") {
                                model.endSession()
                                showingSummary = true
                            }
                            .font(Typography.body)
                            .foregroundStyle(Palette.green)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .scrollContentBackground(.hidden)
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
