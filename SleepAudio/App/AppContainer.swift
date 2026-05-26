//
//  AppContainer.swift
//  SleepAudio
//
//  Phase 0 keeps the container intentionally light. Future services will be
//  registered here so views can stay independent from system integrations.
//

import Foundation
import Combine

final class AppContainer: ObservableObject {
    let appState: AppState
    let router: AppRouter
    let settingsStore: SettingsStore
    let sessionHistoryStore: SessionHistoryStore
    let sleepDetectionService: any SleepDetecting
    let audioManager: any AudioManaging

    init(
        settingsStore: SettingsStore = SettingsStore(),
        sessionHistoryStore: SessionHistoryStore = SessionHistoryStore(),
        router: AppRouter = AppRouter(),
        sleepDetectionService: any SleepDetecting = MockSleepDetectionService(),
        audioManager: any AudioManaging = MockAudioManager()
    ) {
        self.settingsStore = settingsStore
        self.sessionHistoryStore = sessionHistoryStore
        self.appState = AppState(
            settingsStore: settingsStore,
            sessionHistoryStore: sessionHistoryStore
        )
        self.router = router
        self.sleepDetectionService = sleepDetectionService
        self.audioManager = audioManager
    }
}
