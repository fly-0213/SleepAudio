//
//  TodayViewModel.swift
//  SleepAudio
//

import Foundation
import Combine

@MainActor
final class TodayViewModel: ObservableObject {
    @Published private(set) var mode: AppMode
    @Published private(set) var sleepDetectionState: SleepDetectionState = .idle
    @Published private(set) var currentSession: SleepSession?
    @Published private(set) var morningPlaybackState: PlaybackState = .idle
    @Published private(set) var mockMorningVolume = 0.0
    @Published private(set) var morningTargetVolume = MorningPlaybackSettings.default.targetVolume
    @Published private(set) var morningAudioSource: AudioSource?

    private let sleepDetectionService: any SleepDetecting
    private let audioManager: any AudioManaging
    private var nightFlowTask: Task<Void, Never>?
    private var morningFlowTask: Task<Void, Never>?
    private var hasStoppedMorningPlaybackToday = false
    private var hasAutoTriggeredMorningToday = false

    init(
        date: Date = Date(),
        calendar: Calendar = .current,
        sleepDetectionService: any SleepDetecting,
        audioManager: any AudioManaging
    ) {
        mode = AppMode(date: date, calendar: calendar)
        self.sleepDetectionService = sleepDetectionService
        self.audioManager = audioManager
    }

    deinit {
        nightFlowTask?.cancel()
        morningFlowTask?.cancel()
    }

    func startNightFlow(audioSource: AudioSource, targetMorningVolume: Double) {
        guard !sleepDetectionState.isNightFlowActive else { return }

        let session = SleepSession(audioSource: audioSource)
        currentSession = session
        updateDetectionState(.preparing)

        nightFlowTask?.cancel()
        nightFlowTask = Task { [weak self] in
            guard let self else { return }

            do {
                try await Task.sleep(nanoseconds: 650_000_000)
                self.updateDetectionState(.guarding)

                let detectionResult = try await self.sleepDetectionService.waitForLikelySleep(in: session)
                self.updateDetectionState(detectionResult)

                let playbackState = try await self.audioManager.pauseAudio(from: audioSource)
                self.markAudioPaused(playbackState)
                try await Task.sleep(nanoseconds: 1_600_000_000)
                self.startMorningPlaybackIfAllowed(
                    audioSource: audioSource,
                    targetVolume: targetMorningVolume,
                    isAutomatic: true
                )
            } catch is CancellationError {
                return
            } catch {
                self.markFlowEnded()
            }
        }
    }

    func endNightFlow() {
        nightFlowTask?.cancel()
        nightFlowTask = nil
        markFlowEnded()
    }

    func resetToIdle() {
        nightFlowTask?.cancel()
        nightFlowTask = nil
        morningFlowTask?.cancel()
        morningFlowTask = nil
        currentSession = nil
        sleepDetectionState = .idle
        if morningPlaybackState == .stopped {
            morningPlaybackState = .idle
            mockMorningVolume = 0
            morningAudioSource = nil
        }
    }

    func triggerMorningPlaybackForTesting(audioSource: AudioSource, targetVolume: Double) {
        startMorningPlaybackIfAllowed(
            audioSource: audioSource,
            targetVolume: targetVolume,
            isAutomatic: false
        )
    }

    func reduceMorningVolume() {
        guard morningPlaybackState == .fadingIn || morningPlaybackState == .playing else { return }

        morningFlowTask?.cancel()
        morningFlowTask = Task { [weak self] in
            guard let self else { return }

            do {
                let reducedVolume = try await self.audioManager.reduceVolume(currentVolume: self.mockMorningVolume)
                self.morningTargetVolume = max(reducedVolume, 0.10)
                self.mockMorningVolume = min(reducedVolume, self.morningTargetVolume)
                self.morningPlaybackState = self.mockMorningVolume >= self.morningTargetVolume
                    ? .playing
                    : .fadingIn
            } catch {
                self.morningPlaybackState = .stopped
            }
        }
    }

    func stopMorningPlayback() {
        morningFlowTask?.cancel()
        morningFlowTask = Task { [weak self] in
            guard let self else { return }

            do {
                self.morningPlaybackState = try await self.audioManager.stopPlayback()
            } catch {
                self.morningPlaybackState = .stopped
            }

            self.mockMorningVolume = 0
            self.hasStoppedMorningPlaybackToday = true
            self.hasAutoTriggeredMorningToday = true
        }
    }

    private func updateDetectionState(_ state: SleepDetectionState) {
        sleepDetectionState = state
        currentSession?.detectionState = state
    }

    private func markAudioPaused(_ playbackState: PlaybackState) {
        currentSession?.playbackState = playbackState
        currentSession?.pausedAt = Date()
        updateDetectionState(.paused)
    }

    private func markFlowEnded() {
        currentSession?.endedAt = Date()
        updateDetectionState(.ended)
    }

    private func startMorningPlaybackIfAllowed(
        audioSource: AudioSource,
        targetVolume: Double,
        isAutomatic: Bool
    ) {
        guard !hasStoppedMorningPlaybackToday else { return }
        guard morningPlaybackState == .idle || morningPlaybackState == .stopped else { return }

        if isAutomatic {
            guard !hasAutoTriggeredMorningToday else { return }
            hasAutoTriggeredMorningToday = true
        }

        morningFlowTask?.cancel()
        morningAudioSource = audioSource
        morningTargetVolume = min(max(targetVolume, 0.10), 1.0)
        mockMorningVolume = 0
        morningPlaybackState = .fadingIn
        sleepDetectionState = .ended

        morningFlowTask = Task { [weak self] in
            guard let self else { return }

            do {
                self.morningPlaybackState = try await self.audioManager.startMorningPlayback(
                    from: audioSource,
                    targetVolume: self.morningTargetVolume
                )

                let steps = 24
                for step in 1...steps {
                    try Task.checkCancellation()
                    try await Task.sleep(nanoseconds: 140_000_000)

                    let nextVolume = self.morningTargetVolume * (Double(step) / Double(steps))
                    self.mockMorningVolume = try await self.audioManager.updateMockVolume(nextVolume)
                }

                self.mockMorningVolume = self.morningTargetVolume
                self.morningPlaybackState = .playing
            } catch is CancellationError {
                return
            } catch {
                self.morningPlaybackState = .stopped
            }
        }
    }
}
