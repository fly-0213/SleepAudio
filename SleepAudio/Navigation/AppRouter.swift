//
//  AppRouter.swift
//  SleepAudio
//

import SwiftUI
import Combine

final class AppRouter: ObservableObject {
    @Published var selectedTab: AppTab = .today

    @Published var todayPath = NavigationPath()
    @Published var soundPath = NavigationPath()
    @Published var recordsPath = NavigationPath()
    @Published var settingsPath = NavigationPath()

    func resetSelectedTabPath() {
        switch selectedTab {
        case .today:
            todayPath = NavigationPath()
        case .sound:
            soundPath = NavigationPath()
        case .records:
            recordsPath = NavigationPath()
        case .settings:
            settingsPath = NavigationPath()
        }
    }
}
