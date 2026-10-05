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
    #if os(iOS)
        @State private var editMode: EditMode = .inactive
    #endif

    var body: some View {
        ZStack {
            Palette.black.ignoresSafeArea()

            if let model {
                VStack(spacing: 0) {
                    Text("SESSION")
                        .font(Typography.title)
                        .foregroundStyle(Palette.green)
                        .padding(.top, Spacing.md)

                    TimelineView(.periodic(from: model.workout.startedAt, by: 1)) { context in
                        Text(formattedElapsed(from: model.workout.startedAt, to: context.date))
                            .font(Typography.label)
                            .foregroundStyle(Palette.greenDim)
                    }

                    List {
                        ForEach(model.exercises) { item in
                            Section {
                                SessionExerciseRow(item: item) { reps, weight in
                                    model.addSet(to: item.id, reps: reps, weight: weight)
                                } onDeleteSet: { setId in
                                    model.deleteSet(from: item.id, setId: setId)
                                } onMoveSets: { source, destination in
                                    model.moveSets(in: item.id, from: source, to: destination)
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
                    #if os(iOS)
                        .environment(\.editMode, $editMode)
                        .toolbar {
                            Button(editMode.isEditing ? "Done" : "Edit") {
                                editMode = editMode.isEditing ? .inactive : .active
                            }
                            .foregroundStyle(Palette.green)
                        }
                    #endif
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

    private func formattedElapsed(from startedAt: Date, to now: Date) -> String {
        Duration.seconds(now.timeIntervalSince(startedAt))
            .formatted(.time(pattern: .minuteSecond))
    }
}
