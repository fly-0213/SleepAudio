//
//  AudioManaging.swift
//  SleepAudio
//

import Foundation

protocol AudioManaging {
    func pauseAudio(from source: AudioSource) async throws -> PlaybackState
}
