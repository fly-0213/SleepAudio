//
//  AppMode.swift
//  SleepAudio
//

import SwiftUI

enum AppMode: String, CaseIterable, Identifiable {
    case morning
    case daytime
    case evening
    case lateNight

    var id: String { rawValue }

    init(date: Date, calendar: Calendar = .current) {
        let hour = calendar.component(.hour, from: date)

        switch hour {
        case 5...10:
            self = .morning
        case 11...16:
            self = .daytime
        case 17...21:
            self = .evening
        default:
            self = .lateNight
        }
    }

    var title: String {
        switch self {
        case .morning:
            "早上好，今天也慢慢开始吧"
        case .daytime:
            "下午好，保持自己的节奏"
        case .evening:
            "晚上好，准备慢慢放松了吗"
        case .lateNight:
            "夜深了，我会安静陪着你"
        }
    }

    var subtitle: String {
        switch self {
        case .morning:
            "声音会在你醒来时轻轻回来"
        case .daytime:
            "今晚的声音已经准备好"
        case .evening:
            "点一下，就进入夜间守候"
        case .lateNight:
            "睡着后，我会帮你停下声音"
        }
    }

    var sceneSymbol: String {
        switch self {
        case .morning:
            "sunrise.fill"
        case .daytime:
            "sun.max.fill"
        case .evening:
            "sunset.fill"
        case .lateNight:
            "moon.stars.fill"
        }
    }

    var companionSpeech: String {
        switch self {
        case .morning:
            "早上好"
        case .daytime:
            "慢慢来"
        case .evening:
            "今晚交给我吧"
        case .lateNight:
            "我会安静陪着你"
        }
    }

    var accentColor: Color {
        switch self {
        case .morning:
            AppColors.accentMorning
        case .daytime:
            AppColors.accentCalmBlue
        case .evening:
            AppColors.accentMorning
        case .lateNight:
            AppColors.accentMoon
        }
    }

    var sceneColors: [Color] {
        switch self {
        case .morning:
            [
                Color(red: 0.70, green: 0.84, blue: 0.90),
                AppColors.accentMorning.opacity(0.42),
                AppColors.morningBackground
            ]
        case .daytime:
            [
                Color(red: 0.77, green: 0.88, blue: 0.92),
                Color(red: 0.88, green: 0.93, blue: 0.90),
                AppColors.dayBackground
            ]
        case .evening:
            [
                Color(red: 0.34, green: 0.48, blue: 0.58),
                AppColors.accentMorning.opacity(0.55),
                Color(red: 0.92, green: 0.86, blue: 0.78)
            ]
        case .lateNight:
            [
                AppColors.nightBackground,
                AppColors.nightSurface,
                Color(red: 0.13, green: 0.18, blue: 0.23)
            ]
        }
    }

    var prefersDarkScene: Bool {
        self == .lateNight
    }
}
