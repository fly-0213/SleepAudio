//
//  CompanionProfile.swift
//  SleepAudio
//

import Foundation

struct CompanionProfile: Identifiable, Equatable {
    enum Style: String, CaseIterable, Identifiable {
        case gentle

        var id: String { rawValue }
    }

    let id: UUID
    var name: String
    var style: Style

    static let placeholder = CompanionProfile(
        id: UUID(),
        name: "小眠",
        style: .gentle
    )
}
