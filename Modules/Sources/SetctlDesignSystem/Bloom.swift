//
//  Bloom.swift
//  SetctlModules
//
//  Created by Samuel Meads on 10/7/26.
//

import SwiftUI

public extension View {
    func bloom(intensity: Double) -> some View {
        layerEffect(
            ShaderLibrary.bundle(.module).bloom(.float(intensity)),
            maxSampleOffset: CGSize(width: 4, height: 4)
        )
    }
}
