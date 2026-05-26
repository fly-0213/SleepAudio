//
//  SettingsView.swift
//  SleepAudio
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    header
                    settingsPlaceholder
                    emptyState
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("Settings")
                .font(AppTypography.display)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text("Keep the experience calm and personal.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
        }
    }

    private var settingsPlaceholder: some View {
        StatusCard {
            VStack(spacing: 0) {
                SettingsRow(
                    title: "Companion",
                    subtitle: "Appearance and tone",
                    systemImage: "person.crop.circle",
                    trailingText: "Soon"
                )

                Divider()
                    .padding(.leading, 40)

                SettingsRow(
                    title: "Apple Watch",
                    subtitle: "Connection and permissions",
                    systemImage: "applewatch",
                    trailingText: "Mock"
                )
            }
        }
    }

    private var emptyState: some View {
        StatusCard {
            EmptyStateView(
                systemImage: "gearshape",
                title: "Settings will grow carefully",
                message: "Future controls for companion style, permissions, and gentle safeguards will live here.",
                accentColor: AppColors.accentMorning
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                SettingsView()
            }

            NavigationStack {
                SettingsView()
            }
            .preferredColorScheme(.dark)
        }
    }
}
