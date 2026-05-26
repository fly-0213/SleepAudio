//
//  TodayView.swift
//  SleepAudio
//

import SwiftUI

struct TodayView: View {
    @StateObject private var viewModel = TodayViewModel()
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    header

                    DayNightSceneView(
                        mode: viewModel.mode,
                        companionSpeech: viewModel.mode.companionSpeech,
                        isResting: viewModel.isSleepIntentActive
                    )

                    SleepActionPanel(
                        defaultAudioSource: viewModel.defaultAudioSource,
                        morningFadeIn: viewModel.morningFadeIn,
                        nightPauseMode: viewModel.nightPauseMode,
                        buttonTitle: viewModel.primaryButtonTitle,
                        buttonIcon: viewModel.primaryButtonIcon
                    ) {
                        withAnimation(.easeInOut(duration: 0.22)) {
                            viewModel.startSleepIntentPreview()
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
            .navigationTitle("今日")
            .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(viewModel.mode.title)
                    .font(AppTypography.title1)
                    .foregroundStyle(AppColors.primaryText(for: colorScheme))
                    .fixedSize(horizontal: false, vertical: true)

                Text(viewModel.mode.subtitle)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.secondaryText(for: colorScheme))
            }

            Spacer(minLength: AppSpacing.md)

            Image(systemName: "applewatch")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(AppColors.accentCalmBlue)
                .frame(width: 44, height: 44)
                .background(AppColors.cardBackground(for: colorScheme))
                .clipShape(Circle())
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                TodayView()
            }
            .environmentObject(AppState())
            .previewDisplayName("今日")

            NavigationStack {
                TodayView()
            }
            .environmentObject(AppState())
            .preferredColorScheme(.dark)
            .previewDisplayName("今日 深色")
        }
    }
}
