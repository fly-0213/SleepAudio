//
//  MorningPlaybackSettings.swift
//  SleepAudio
//

import Foundation

struct MorningPlaybackSettings: Equatable, Codable {
    enum FadeInDuration: Int, CaseIterable, Identifiable, Codable {
        case five = 5
        case ten = 10
        case fifteen = 15
        case twenty = 20
        case thirty = 30

        var id: Int { rawValue }

        var displayName: String {
            "\(rawValue) 分钟"
        }
    }

    var fadeInDuration: FadeInDuration
    var targetVolume: Double

    static let `default` = MorningPlaybackSettings(
        fadeInDuration: .fifteen,
        targetVolume: 0.35
    )

    var targetVolumeDisplayName: String {
        "\(Int((targetVolume * 100).rounded()))%"
    }
}
