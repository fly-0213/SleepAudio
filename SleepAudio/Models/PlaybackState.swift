//
//  PlaybackState.swift
//  SleepAudio
//

import Foundation

enum PlaybackState: String, Codable {
    case idle
    case mockReady
    case mockPlaying
    case mockPaused

    var displayName: String {
        switch self {
        case .idle:
            "安静待机"
        case .mockReady:
            "模拟准备中"
        case .mockPlaying:
            "模拟播放中"
        case .mockPaused:
            "模拟已暂停"
        }
    }
}
