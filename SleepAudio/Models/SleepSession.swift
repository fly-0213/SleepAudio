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
    var estimatedSleepAt: Date?
    var pausedAt: Date?
    var wakeAt: Date?
    var morningPlaybackStartedAt: Date?
    var morningPlaybackEndedAt: Date?

    init(
        id: UUID = UUID(),
        startedAt: Date = Date(),
        endedAt: Date? = nil,
        audioSource: AudioSource,
        detectionState: SleepDetectionState = .preparing,
        playbackState: PlaybackState = .playing,
        estimatedSleepAt: Date? = nil,
        pausedAt: Date? = nil,
        wakeAt: Date? = nil,
        morningPlaybackStartedAt: Date? = nil,
        morningPlaybackEndedAt: Date? = nil
    ) {
        self.id = id
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.audioSource = audioSource
        self.detectionState = detectionState
        self.playbackState = playbackState
        self.estimatedSleepAt = estimatedSleepAt
        self.pausedAt = pausedAt
        self.wakeAt = wakeAt
        self.morningPlaybackStartedAt = morningPlaybackStartedAt
        self.morningPlaybackEndedAt = morningPlaybackEndedAt
    }

    var sessionRecord: SessionRecord {
        SessionRecord(
            id: id,
            sessionDate: startedAt,
            guardingStartedAt: startedAt,
            estimatedSleepAt: estimatedSleepAt,
            audioPausedAt: pausedAt,
            wakeAt: wakeAt,
            morningPlaybackStartedAt: morningPlaybackStartedAt,
            morningPlaybackEndedAt: morningPlaybackEndedAt,
            audioSource: audioSource,
            finalPlaybackState: playbackState
        )
    }
}
