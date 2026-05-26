//
//  SoundSettingsView.swift
//  SleepAudio
//

import SwiftUI

struct SoundSettingsView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    header

                    StatusCard {
                        EmptyStateView(
                            systemImage: "waveform",
                            title: "Sound settings are waiting",
                            message: "Your default audio app, gentle morning fade, and night pause preferences will appear here.",
                            accentColor: AppColors.accentCalmBlue
                        )
                    }
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
        .navigationTitle("Sound")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("Sound")
                .font(AppTypography.display)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text("Choose what gently fills the room.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
        }
    }
}

struct SoundSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                SoundSettingsView()
            }

            NavigationStack {
                SoundSettingsView()
            }
            .preferredColorScheme(.dark)
        }
    }
}
