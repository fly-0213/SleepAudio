//
//  AppContainer.swift
//  SleepAudio
//
//  Phase 0 keeps the container intentionally light. Future services will be
//  registered here so views can stay independent from system integrations.
//

import Foundation

final class AppContainer {
    let appState: AppState
    let router: AppRouter
    let settingsStore: SettingsStore

    init(
        settingsStore: SettingsStore = SettingsStore(),
        router: AppRouter = AppRouter()
    ) {
        self.settingsStore = settingsStore
        self.appState = AppState(settingsStore: settingsStore)
        self.router = router
    }
}
