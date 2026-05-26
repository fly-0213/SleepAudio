//
//  SleepDetectionState.swift
//  SleepAudio
//

import Foundation

enum SleepDetectionState: String, Codable, Equatable {
    case idle
    case preparing
    case guarding
    case likelyAsleep
    case paused
    case ended

    var statusTitle: String {
        switch self {
        case .idle:
            "今晚声音已经准备好"
        case .preparing:
            "正在进入夜间守候"
        case .guarding:
            "正在安静守候"
        case .likelyAsleep:
            "可能已入睡"
        case .paused:
            "声音已为你停下"
        case .ended:
            "守候已结束"
        }
    }

    var statusMessage: String {
        switch self {
        case .idle:
            "点一下，我会在你准备睡觉时开始陪着你。"
        case .preparing:
            "晚安，我会安静陪着你。"
        case .guarding:
            "如果你睡着了，我会帮你停下声音。"
        case .likelyAsleep:
            "我感觉你可能睡着了，正在轻轻停下声音。"
        case .paused:
            "可以安心休息了。"
        case .ended:
            "已经回到安静的夜晚状态。"
        }
    }

    var companionSpeech: String? {
        switch self {
        case .idle:
            nil
        case .preparing:
            "晚安"
        case .guarding:
            "我会安静陪着你"
        case .likelyAsleep:
            "声音会慢慢停下"
        case .paused:
            "可以安心休息了"
        case .ended:
            "明天见"
        }
    }

    var isNightFlowActive: Bool {
        switch self {
        case .preparing, .guarding, .likelyAsleep, .paused:
            true
        case .idle, .ended:
            false
        }
    }

    var shouldShowResult: Bool {
        self == .paused
    }
}
