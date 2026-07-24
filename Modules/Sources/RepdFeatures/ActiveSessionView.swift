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
    @State private var exercises: [Exercise] = []

    var body: some View {
        List(exercises) { exercise in
            Text(exercise.name)
                .font(Typography.body)
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

#Preview {
    ActiveSessionView()
}
