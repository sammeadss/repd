//
//  Colors.swift
//  RepdModules
//
//  Created by Samuel Meads on 6/24/26.
//

import SwiftUI

extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

public enum Palette {
    public static let black = Color(hex: 0x000000)
    public static let green = Color(hex: 0x00FF66)
    public static let greenDim = Color(hex: 0x4F9E6A)
    public static let greenFaint = Color(hex: 0x1E4D33)
    public static let amber = Color(hex: 0xFFB000)
    public static let red = Color(hex: 0xFF5C5C)
}
