//
//  CompanionProfile.swift
//  SleepAudio
//

import Foundation

struct CompanionProfile: Identifiable, Equatable, Codable {
    enum Style: String, CaseIterable, Identifiable, Codable {
        case male
        case female

        var id: String { rawValue }

        var title: String {
            switch self {
            case .male:
                "男生陪伴"
            case .female:
                "女生陪伴"
            }
        }

        var subtitle: String {
            switch self {
            case .male:
                "温和、稳稳地陪你进入夜晚"
            case .female:
                "柔软、轻轻地陪你醒来入睡"
            }
        }

        var symbolName: String {
            switch self {
            case .male:
                "person.fill"
            case .female:
                "person.fill"
            }
        }
    }

    let id: UUID
    var name: String
    var style: Style

    static let female = CompanionProfile(
        id: UUID(),
        name: "小眠",
        style: .female
    )

    static let male = CompanionProfile(
        id: UUID(),
        name: "阿眠",
        style: .male
    )
}
