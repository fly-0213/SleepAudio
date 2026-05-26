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

    init(
        appState: AppState = AppState(),
        router: AppRouter = AppRouter()
    ) {
        self.appState = appState
        self.router = router
    }
}
