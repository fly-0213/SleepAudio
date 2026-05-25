//
//  AppColors.swift
//  SleepAudio
//

import SwiftUI

enum AppColors {
    static let morningBackground = Color(red: 0.969, green: 0.949, blue: 0.918)
    static let dayBackground = Color(red: 0.965, green: 0.969, blue: 0.957)
    static let nightBackground = Color(red: 0.055, green: 0.078, blue: 0.102)
    static let nightSurface = Color(red: 0.090, green: 0.129, blue: 0.169)

    static let primaryTextLight = Color(red: 0.137, green: 0.153, blue: 0.165)
    static let primaryTextDark = Color(red: 0.957, green: 0.941, blue: 0.910)
    static let secondaryTextLight = Color(red: 0.435, green: 0.467, blue: 0.490)
    static let secondaryTextDark = Color(red: 0.663, green: 0.702, blue: 0.729)

    static let accentMorning = Color(red: 0.898, green: 0.682, blue: 0.408)
    static let accentCalmBlue = Color(red: 0.471, green: 0.686, blue: 0.784)
    static let accentMoon = Color(red: 0.867, green: 0.902, blue: 0.925)
    static let successSoft = Color(red: 0.557, green: 0.737, blue: 0.608)

    static func appBackground(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? nightBackground : morningBackground
    }

    static func cardBackground(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? nightSurface : .white
    }

    static func primaryText(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? primaryTextDark : primaryTextLight
    }

    static func secondaryText(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? secondaryTextDark : secondaryTextLight
    }

    static func primaryButtonBackground(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? primaryTextDark : primaryTextLight
    }

    static func primaryButtonText(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? primaryTextLight : .white
    }
}
