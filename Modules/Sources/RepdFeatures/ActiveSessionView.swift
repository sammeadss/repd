//
//  ActiveSessionView.swift
//  RepdModules
//
//  Created by Samuel Meads on 7/23/26.
//

import RepdDesignSystem
import SwiftUI

struct ActiveSessionView: View {
    var body: some View {
        ZStack {
            Palette.black.ignoresSafeArea()

            Text("SESSION")
                .font(Typography.title)
                .foregroundStyle(Palette.green)
        }
    }
}

#Preview {
    ActiveSessionView()
}
