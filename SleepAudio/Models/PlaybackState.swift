//
//  PlaybackState.swift
//  SleepAudio
//

import Foundation

enum PlaybackState: String, Codable, Equatable {
    case idle
    case fadingIn
    case playing
    case paused
    case stopped

    var displayName: String {
        switch self {
        case .idle:
            "安静待机"
        case .fadingIn:
            "渐入中"
        case .playing:
            "正在播放"
        case .paused:
            "已暂停"
        case .stopped:
            "已停止"
        }
    }
}
