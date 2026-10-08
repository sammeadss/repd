//
//  Typography.swift
//  SetctlModules
//
//  Created by Samuel Meads on 6/24/26.
//

import SwiftUI

public enum Typography {
    public static let hero = Font.custom("VT323-Regular", size: 56)
    public static let title = Font.custom("VT323-Regular", size: 32)
    public static let headline = Font.system(size: 20, weight: .regular, design: .monospaced)
    public static let body = Font.system(size: 16, weight: .regular, design: .monospaced)
    public static let label = Font.system(size: 13, weight: .regular, design: .monospaced)
    public static let caption = Font.system(size: 11, weight: .regular, design: .monospaced)
}
