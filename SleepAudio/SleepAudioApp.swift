//
//  SleepAudioApp.swift
//  SleepAudio
//
//  Created by F.ly on 5/25/26.
//

import SwiftUI

@main
struct SleepAudioApp: App {
    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(container)
                .environmentObject(container.appState)
                .environmentObject(container.router)
        }
    }
}
