//
//  ContentView.swift
//  SleepAudio
//
//  Created by F.ly on 5/25/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        if appState.hasCompletedOnboarding {
            MainTabView()
        } else {
            OnboardingFlowView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(AppContainer())
                .environmentObject(AppState())
                .environmentObject(AppRouter())
                .previewDisplayName("主界面")

            ContentView()
                .environmentObject(AppContainer())
                .environmentObject(AppState())
                .environmentObject(AppRouter())
                .preferredColorScheme(.dark)
                .previewDisplayName("主界面 深色")
        }
    }
}
