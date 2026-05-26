//
//  AudioSource.swift
//  SleepAudio
//

import Foundation

enum AudioSource: String, CaseIterable, Identifiable, Codable {
    case appleMusic
    case spotify
    case podcasts
    case tomatoNovel
    case shortcuts

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .appleMusic:
            "Apple Music"
        case .spotify:
            "Spotify"
        case .podcasts:
            "播客"
        case .tomatoNovel:
            "番茄小说"
        case .shortcuts:
            "快捷指令"
        }
    }

    var description: String {
        switch self {
        case .appleMusic:
            "适合用音乐轻轻开始一天"
        case .spotify:
            "适合播放常听歌单或氛围音乐"
        case .podcasts:
            "适合播客和轻松的睡前内容"
        case .tomatoNovel:
            "适合有声小说和长篇故事"
        case .shortcuts:
            "适合之后接入更灵活的自动化"
        }
    }

    var symbolName: String {
        switch self {
        case .appleMusic:
            "music.note"
        case .spotify:
            "music.quarternote.3"
        case .podcasts:
            "dot.radiowaves.left.and.right"
        case .tomatoNovel:
            "book.closed"
        case .shortcuts:
            "sparkles"
        }
    }
}
