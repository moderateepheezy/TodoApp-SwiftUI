//
//  Color+Extension.swift
//  TodoApp
//
//  Created by Afees Lawal on 04/08/2020.
//

import SwiftUI

extension Color {
    static let backgroundColor = Color("backgroundColor")
    static let primaryTextColor = Color("primaryTextColor")
    static let infoColor = Color("infoColor")
    static let lightGreen = Color(hex: "91DC5A")
    static let lightYellow = Color(hex: "FFDC00")
    static let reminderViewBackgroundColor = Color("reminderViewBackgroundColor")

    static let todoGradientFirstColor = Color("todoGradientFirstColor")
    static let todoGradientSecondColor = Color("todoGradientSecondColor")
    static let todoHeaderGradientFirstColor = Color("todoHeaderGradientFirstColor")
    static let todoHeaderGradientSecondColor = Color("todoHeaderGradientSecondColor")


    static let shadowColor = Color(hex: "66C81C")
    static let addTaskButtonColor = Color(hex: "E0139C")
    static let addTaskButtonShadowColor = Color("addTaskButtonShadowColor")
    static let sectionTitleColor = Color(hex: "8B87B3")
    static let rowColor = Color("rowColor")

    static func categoryColor(for category: Todo.Category) -> Color {
        switch category {
        case .personal:
            return Color(hex: "FFD506")
        case .work:
            return Color(hex: "1ED102")
        case .meeting:
            return Color(hex: "D10263")
        case .study:
            return Color(hex: "3044F2")
        case .party:
            return Color(hex: "F59BFF")
        case .shopping:
            return Color(hex: "F29130")
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
