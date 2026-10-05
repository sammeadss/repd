//
//  ExercisePickerView.swift
//  SetctlModules
//
//  Created by Samuel Meads on 7/25/26.
//

import SetctlData
import SetctlDesignSystem
import SwiftUI

struct ExercisePickerView: View {
    @Environment(AppModel.self) private var appModel
    @State private var exercises: [Exercise] = []
    @State private var searchText = ""
    let onSelect: (Exercise) -> Void

    private var filteredExercises: [Exercise] {
        searchText.isEmpty
            ? exercises
            : exercises.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Palette.black.ignoresSafeArea()

                List(filteredExercises) { exercise in
                    Button(exercise.name) {
                        onSelect(exercise)
                    }
                    .foregroundStyle(Palette.green)
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
            }
            .searchable(text: $searchText, prompt: "Search exercises")
        }
        .task {
            do {
                exercises = try appModel.exerciseRepository.fetchAllExercises()
            } catch {
                print("Failed to load exercises: \(error)")
            }
        }
    }
}
