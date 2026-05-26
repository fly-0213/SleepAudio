//
//  SessionRecord.swift
//  SleepAudio
//

import Foundation

struct SessionRecord: Identifiable, Equatable, Codable {
    let id: UUID
    var sessionDate: Date
    var guardingStartedAt: Date
    var estimatedSleepAt: Date?
    var audioPausedAt: Date?
    var wakeAt: Date?
    var morningPlaybackStartedAt: Date?
    var morningPlaybackEndedAt: Date?
    var audioSource: AudioSource
    var finalPlaybackState: PlaybackState

    var guardedDuration: TimeInterval {
        let end = audioPausedAt ?? Date()
        return max(end.timeIntervalSince(guardingStartedAt), 0)
    }

    var morningPlaybackDuration: TimeInterval? {
        guard
            let morningPlaybackStartedAt,
            let morningPlaybackEndedAt
        else {
            return nil
        }

        return max(morningPlaybackEndedAt.timeIntervalSince(morningPlaybackStartedAt), 0)
    }

    static let preview = SessionRecord(
        id: UUID(),
        sessionDate: Date(),
        guardingStartedAt: Date().addingTimeInterval(-3_600),
        estimatedSleepAt: Date().addingTimeInterval(-2_500),
        audioPausedAt: Date().addingTimeInterval(-2_400),
        wakeAt: Date().addingTimeInterval(-900),
        morningPlaybackStartedAt: Date().addingTimeInterval(-850),
        morningPlaybackEndedAt: Date().addingTimeInterval(-130),
        audioSource: .spotify,
        finalPlaybackState: .stopped
    )
}
