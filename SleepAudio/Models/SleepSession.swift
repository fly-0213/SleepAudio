//
//  SleepSession.swift
//  SleepAudio
//

import Foundation

struct SleepSession: Identifiable, Equatable, Codable {
    let id: UUID
    let startedAt: Date
    var endedAt: Date?
    var audioSource: AudioSource
    var detectionState: SleepDetectionState
    var playbackState: PlaybackState
    var pausedAt: Date?

    init(
        id: UUID = UUID(),
        startedAt: Date = Date(),
        endedAt: Date? = nil,
        audioSource: AudioSource,
        detectionState: SleepDetectionState = .preparing,
        playbackState: PlaybackState = .mockPlaying,
        pausedAt: Date? = nil
    ) {
        self.id = id
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.audioSource = audioSource
        self.detectionState = detectionState
        self.playbackState = playbackState
        self.pausedAt = pausedAt
    }
}
