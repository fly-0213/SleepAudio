//
//  MockAudioManager.swift
//  SleepAudio
//

import Foundation

struct MockAudioManager: AudioManaging {
    var pauseDelayInNanoseconds: UInt64 = 900_000_000
    var playbackDelayInNanoseconds: UInt64 = 300_000_000

    func pauseAudio(from source: AudioSource) async throws -> PlaybackState {
        try await Task.sleep(nanoseconds: pauseDelayInNanoseconds)
        return .paused
    }

    func startMorningPlayback(from source: AudioSource, targetVolume: Double) async throws -> PlaybackState {
        try await Task.sleep(nanoseconds: playbackDelayInNanoseconds)
        return .fadingIn
    }

    func updateMockVolume(_ volume: Double) async throws -> Double {
        min(max(volume, 0), 1)
    }

    func reduceVolume(currentVolume: Double) async throws -> Double {
        min(max(currentVolume - 0.10, 0), 1)
    }

    func stopPlayback() async throws -> PlaybackState {
        try await Task.sleep(nanoseconds: playbackDelayInNanoseconds)
        return .stopped
    }
}
