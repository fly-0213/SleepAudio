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

    private let sleepDetectionService: any SleepDetecting
    private let audioManager: any AudioManaging
    private var nightFlowTask: Task<Void, Never>?

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
    }

    func startNightFlow(audioSource: AudioSource) {
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
        currentSession = nil
        sleepDetectionState = .idle
    }

    var isResting: Bool {
        sleepDetectionState.isNightFlowActive || sleepDetectionState == .ended
    }

    var companionSpeech: String {
        sleepDetectionState.companionSpeech ?? mode.companionSpeech
    }

    var sceneMode: AppMode {
        sleepDetectionState == .idle ? mode : .lateNight
    }

    var headerTitle: String {
        switch sleepDetectionState {
        case .idle:
            mode.title
        case .preparing:
            "晚安，我会安静陪着你"
        case .guarding:
            "正在安静守候"
        case .likelyAsleep:
            "可能已经睡着了"
        case .paused:
            "昨晚声音已停下"
        case .ended:
            "今晚先回到安静"
        }
    }

    var headerSubtitle: String {
        switch sleepDetectionState {
        case .idle:
            mode.subtitle
        case .preparing:
            "正在为夜晚准备一个轻一点的状态"
        case .guarding:
            "如果你睡着了，我会帮你停下声音"
        case .likelyAsleep:
            "正在模拟暂停当前声音"
        case .paused:
            "声音已为你停下，可以安心休息了"
        case .ended:
            "守候已经结束，需要时可以再次开始"
        }
    }

    var primaryButtonTitle: String {
        switch sleepDetectionState {
        case .idle:
            "我要睡了"
        case .preparing, .guarding, .likelyAsleep:
            "守候中"
        case .paused:
            "昨晚声音已停下"
        case .ended:
            "回到今日"
        }
    }

    var primaryButtonIcon: String {
        switch sleepDetectionState {
        case .idle:
            "moon.zzz"
        case .preparing, .guarding:
            "shield.lefthalf.filled"
        case .likelyAsleep:
            "moon.zzz.fill"
        case .paused:
            "checkmark"
        case .ended:
            "sunrise"
        }
    }

    var shouldDisablePrimaryButton: Bool {
        switch sleepDetectionState {
        case .preparing, .guarding, .likelyAsleep, .paused:
            true
        case .idle, .ended:
            false
        }
    }

    var shouldShowEndButton: Bool {
        sleepDetectionState.isNightFlowActive
    }

    var statusTitle: String {
        sleepDetectionState.statusTitle
    }

    var statusMessage: String {
        sleepDetectionState.statusMessage
    }

    var resultTitle: String? {
        sleepDetectionState == .paused ? "昨晚声音已停下" : nil
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
}
