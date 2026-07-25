//
//  ExercisePickerView.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/25/26.
//

import RepdData
import RepdDesignSystem
import SwiftUI

struct ExercisePickerView: View {
    @Environment(AppModel.self) private var appModel
    @State private var exercises: [Exercise] = []
    let onSelect: (Exercise) -> Void

    var body: some View {
        List(exercises) { exercise in
            Button(exercise.name) {
                onSelect(exercise)
            }
            .foregroundStyle(Palette.green)
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
