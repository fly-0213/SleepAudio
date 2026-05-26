//
//  MockAudioManager.swift
//  SleepAudio
//

import Foundation

struct MockAudioManager: AudioManaging {
    var pauseDelayInNanoseconds: UInt64 = 900_000_000

    func pauseAudio(from source: AudioSource) async throws -> PlaybackState {
        try await Task.sleep(nanoseconds: pauseDelayInNanoseconds)
        return .mockPaused
    }
}
