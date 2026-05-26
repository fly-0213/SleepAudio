//
//  NightPauseSettings.swift
//  SleepAudio
//

import Foundation

struct NightPauseSettings: Equatable, Codable {
    enum TimingPreference: String, CaseIterable, Identifiable, Codable {
        case earlier
        case balanced
        case later

        var id: String { rawValue }

        var displayName: String {
            switch self {
            case .earlier:
                "更早暂停"
            case .balanced:
                "平衡模式"
            case .later:
                "更晚暂停"
            }
        }

        var description: String {
            switch self {
            case .earlier:
                "适合容易被声音影响入睡的人"
            case .balanced:
                "适合大多数夜晚的温和判断"
            case .later:
                "适合希望声音多陪一会儿的人"
            }
        }
    }

    var timingPreference: TimingPreference

    static let `default` = NightPauseSettings(timingPreference: .balanced)
}
