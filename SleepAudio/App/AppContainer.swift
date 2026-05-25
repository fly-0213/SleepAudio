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

    init(appState: AppState = AppState()) {
        self.appState = appState
    }
}
