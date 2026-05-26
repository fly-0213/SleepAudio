//
//  AudioManaging.swift
//  SleepAudio
//

import Foundation

protocol AudioManaging {
    func pauseAudio(from source: AudioSource) async throws -> PlaybackState
    func startMorningPlayback(from source: AudioSource, targetVolume: Double) async throws -> PlaybackState
    func updateMockVolume(_ volume: Double) async throws -> Double
    func reduceVolume(currentVolume: Double) async throws -> Double
    func stopPlayback() async throws -> PlaybackState
}
