//
//  Typography.swift
//  RepdModules
//
//  Created by Samuel Meads on 6/24/26.
//

import SwiftUI

public enum Typography {
    // Display roles (hero, title) will move to a custom pixel font later
    // until then all roles use the monospaced system font
    public static let hero = Font.system(size: 56, weight: .bold, design: .monospaced)
    public static let title = Font.system(size: 32, weight: .bold, design: .monospaced)
    public static let headline = Font.system(size: 20, weight: .regular, design: .monospaced)
    public static let body = Font.system(size: 16, weight: .regular, design: .monospaced)
    public static let label = Font.system(size: 13, weight: .regular, design: .monospaced)
    public static let caption = Font.system(size: 11, weight: .regular, design: .monospaced)
}
