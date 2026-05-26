//
//  TodayViewModel+Display.swift
//  SleepAudio
//

import Foundation

extension TodayViewModel {
    var isResting: Bool {
        if isMorningPlaybackVisible {
            return false
        }

        return sleepDetectionState.isNightFlowActive || sleepDetectionState == .ended
    }

    var companionSpeech: String {
        if isMorningPlaybackVisible {
            switch morningPlaybackState {
            case .fadingIn, .playing:
                return "早上好"
            case .stopped:
                return "慢慢开始吧"
            case .idle, .paused:
                break
            }
        }

        return sleepDetectionState.companionSpeech ?? mode.companionSpeech
    }

    var sceneMode: AppMode {
        if isMorningPlaybackVisible {
            return .morning
        }

        return sleepDetectionState == .idle ? mode : .lateNight
    }

    var headerTitle: String {
        if isMorningPlaybackVisible {
            switch morningPlaybackState {
            case .fadingIn, .playing:
                return "早上好，今天慢慢开始吧"
            case .stopped:
                return "声音已经停下"
            case .idle, .paused:
                break
            }
        }

        switch sleepDetectionState {
        case .idle:
            return mode.title
        case .preparing:
            return "晚安，我会安静陪着你"
        case .guarding:
            return "正在安静守候"
        case .likelyAsleep:
            return "可能已经睡着了"
        case .paused:
            return "昨晚声音已停下"
        case .ended:
            return "今晚先回到安静"
        }
    }

    var headerSubtitle: String {
        if isMorningPlaybackVisible {
            switch morningPlaybackState {
            case .fadingIn, .playing:
                return "正在轻柔播放，房间会一点点亮起来"
            case .stopped:
                return "今天不会再自动开始播放"
            case .idle, .paused:
                break
            }
        }

        switch sleepDetectionState {
        case .idle:
            return mode.subtitle
        case .preparing:
            return "正在为夜晚准备一个轻一点的状态"
        case .guarding:
            return "如果你睡着了，我会帮你停下声音"
        case .likelyAsleep:
            return "正在模拟暂停当前声音"
        case .paused:
            return "声音已为你停下，可以安心休息了"
        case .ended:
            return "守候已经结束，需要时可以再次开始"
        }
    }

    var statusTitle: String {
        sleepDetectionState.statusTitle
    }

    var statusMessage: String {
        sleepDetectionState.statusMessage
    }

    var resultTitle: String? {
        sleepDetectionState == .paused ? "昨晚声音已停下" : nil
    }

    var primaryButtonTitle: String {
        switch sleepDetectionState {
        case .idle:
            "我要睡了"
        case .preparing, .guarding, .likelyAsleep:
            "守候中"
        case .paused:
            "昨晚声音已停下"
        case .ended:
            "回到今日"
        }
    }

    var primaryButtonIcon: String {
        switch sleepDetectionState {
        case .idle:
            "moon.zzz"
        case .preparing, .guarding:
            "shield.lefthalf.filled"
        case .likelyAsleep:
            "moon.zzz.fill"
        case .paused:
            "checkmark"
        case .ended:
            "sunrise"
        }
    }

    var shouldDisablePrimaryButton: Bool {
        switch sleepDetectionState {
        case .preparing, .guarding, .likelyAsleep, .paused:
            true
        case .idle, .ended:
            false
        }
    }

    var shouldShowEndButton: Bool {
        sleepDetectionState.isNightFlowActive
    }

    var isMorningPlaybackVisible: Bool {
        switch morningPlaybackState {
        case .fadingIn, .playing, .stopped:
            true
        case .idle, .paused:
            false
        }
    }

    var morningVolumeProgress: Double {
        guard morningTargetVolume > 0 else { return 0 }
        return min(mockMorningVolume / morningTargetVolume, 1)
    }
}
