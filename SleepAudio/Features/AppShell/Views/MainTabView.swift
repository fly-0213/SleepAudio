//
//  MainTabView.swift
//  SleepAudio
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var router: AppRouter

    var body: some View {
        TabView(selection: $router.selectedTab) {
            todayStack
                .tabItem {
                    Label(AppTab.today.title, systemImage: tabIcon(for: .today))
                }
                .tag(AppTab.today)

            soundStack
                .tabItem {
                    Label(AppTab.sound.title, systemImage: tabIcon(for: .sound))
                }
                .tag(AppTab.sound)

            recordsStack
                .tabItem {
                    Label(AppTab.records.title, systemImage: tabIcon(for: .records))
                }
                .tag(AppTab.records)

            settingsStack
                .tabItem {
                    Label(AppTab.settings.title, systemImage: tabIcon(for: .settings))
                }
                .tag(AppTab.settings)
        }
        .tint(AppColors.accentCalmBlue)
    }

    private var todayStack: some View {
        NavigationStack(path: $router.todayPath) {
            TodayView()
                .navigationDestination(for: AppRoute.self) { route in
                    PlaceholderRouteView(route: route)
                }
        }
    }

    private var soundStack: some View {
        NavigationStack(path: $router.soundPath) {
            SoundSettingsView()
                .navigationDestination(for: AppRoute.self) { route in
                    PlaceholderRouteView(route: route)
                }
        }
    }

    private var recordsStack: some View {
        NavigationStack(path: $router.recordsPath) {
            RecordsView()
                .navigationDestination(for: AppRoute.self) { route in
                    PlaceholderRouteView(route: route)
                }
        }
    }

    private var settingsStack: some View {
        NavigationStack(path: $router.settingsPath) {
            SettingsView()
                .navigationDestination(for: AppRoute.self) { route in
                    PlaceholderRouteView(route: route)
                }
        }
    }

    private func tabIcon(for tab: AppTab) -> String {
        router.selectedTab == tab ? tab.selectedSystemImage : tab.systemImage
    }
}

private struct PlaceholderRouteView: View {
    let route: AppRoute

    var body: some View {
        switch route {
        case .placeholder(let title):
            Text(title)
                .font(AppTypography.title1)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainTabView()
                .environmentObject(AppState())
                .environmentObject(AppRouter())
                .previewDisplayName("Main Tabs")

            MainTabView()
                .environmentObject(AppState())
                .environmentObject(AppRouter())
                .preferredColorScheme(.dark)
                .previewDisplayName("Main Tabs Dark")
        }
    }
}
