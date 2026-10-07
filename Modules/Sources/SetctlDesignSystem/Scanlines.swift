//
//  Scanlines.swift
//  SetctlModules
//
//  Created by Samuel Meads on 10/6/26.
//

import SwiftUI

public extension View {
    func scanlines(isEnabled: Bool) -> some View {
        colorEffect(ShaderLibrary.bundle(.module).scanlines(), isEnabled: isEnabled)
    }
}

#Preview {
    ZStack {
        Palette.black.ignoresSafeArea()
        Text("SETCTL")
            .font(Typography.hero)
            .foregroundStyle(Palette.green)
    }
    .scanlines(isEnabled: true)
}
