//
//  AppTab.swift
//  SleepAudio
//

import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case today
    case sound
    case records
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .today:
            "今日"
        case .sound:
            "声音"
        case .records:
            "记录"
        case .settings:
            "设置"
        }
    }

    var systemImage: String {
        switch self {
        case .today:
            "sun.max"
        case .sound:
            "waveform"
        case .records:
            "clock"
        case .settings:
            "gearshape"
        }
    }

    var selectedSystemImage: String {
        switch self {
        case .today:
            "sun.max.fill"
        case .sound:
            "waveform"
        case .records:
            "clock.fill"
        case .settings:
            "gearshape.fill"
        }
    }
}
