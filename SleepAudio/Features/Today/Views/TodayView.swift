//
//  TodayView.swift
//  SleepAudio
//

import SwiftUI

struct TodayView: View {
    @StateObject private var viewModel: TodayViewModel
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme

    init(
        sleepDetectionService: any SleepDetecting = MockSleepDetectionService(),
        audioManager: any AudioManaging = MockAudioManager()
    ) {
        _viewModel = StateObject(
            wrappedValue: TodayViewModel(
                sleepDetectionService: sleepDetectionService,
                audioManager: audioManager
            )
        )
    }

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    header

                    DayNightSceneView(
                        mode: viewModel.sceneMode,
                        companionProfile: appState.selectedCompanionProfile,
                        companionSpeech: viewModel.companionSpeech,
                        isResting: viewModel.isResting
                    )

                    if let latestRecord = appState.latestSessionRecord {
                        recentRecordSummary(latestRecord)
                    }

                    if viewModel.isMorningPlaybackVisible {
                        MorningPlaybackPanel(
                            audioSourceName: viewModel.morningAudioSource?.displayName ?? appState.selectedAudioSource.displayName,
                            playbackState: viewModel.morningPlaybackState,
                            currentVolume: viewModel.mockMorningVolume,
                            targetVolume: viewModel.morningTargetVolume,
                            progress: viewModel.morningVolumeProgress
                        ) {
                            withAnimation(.easeInOut(duration: 0.22)) {
                                viewModel.reduceMorningVolume()
                            }
                        } stopAction: {
                            withAnimation(.easeInOut(duration: 0.22)) {
                                viewModel.stopMorningPlayback()
                            }
                        } dismissAction: {
                            withAnimation(.easeInOut(duration: 0.22)) {
                                viewModel.resetToIdle()
                            }
                        }
                    } else {
                        SleepActionPanel(
                            defaultAudioSource: appState.selectedAudioSource.displayName,
                            morningFadeIn: appState.morningPlaybackSettings.fadeInDuration.displayName,
                            nightPauseMode: appState.nightPauseSettings.timingPreference.displayName,
                            statusTitle: viewModel.sleepDetectionState == .idle ? nil : viewModel.statusTitle,
                            statusMessage: viewModel.sleepDetectionState == .idle ? nil : viewModel.statusMessage,
                            resultTitle: viewModel.resultTitle,
                            buttonTitle: viewModel.primaryButtonTitle,
                            buttonIcon: viewModel.primaryButtonIcon,
                            isPrimaryDisabled: viewModel.shouldDisablePrimaryButton,
                            endButtonTitle: viewModel.shouldShowEndButton ? "结束守候" : nil
                        ) {
                            handlePrimaryAction()
                        } endAction: {
                            withAnimation(.easeInOut(duration: 0.22)) {
                                viewModel.endNightFlow()
                            }
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
            .onChange(of: viewModel.pendingSessionRecord) { _, record in
                guard let record else { return }
                appState.upsertSessionRecord(record)
            }
    }

    private func handlePrimaryAction() {
        withAnimation(.easeInOut(duration: 0.22)) {
            if viewModel.sleepDetectionState == .ended {
                viewModel.resetToIdle()
            } else {
                viewModel.startNightFlow(
                    audioSource: appState.selectedAudioSource,
                    targetMorningVolume: appState.morningPlaybackSettings.targetVolume
                )
            }
        }
    }

    private func triggerMorningPlaybackForTesting() {
        withAnimation(.easeInOut(duration: 0.22)) {
            viewModel.triggerMorningPlaybackForTesting(
                audioSource: appState.selectedAudioSource,
                targetVolume: appState.morningPlaybackSettings.targetVolume
            )
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(viewModel.headerTitle)
                    .font(AppTypography.title1)
                    .foregroundStyle(AppColors.primaryText(for: colorScheme))
                    .fixedSize(horizontal: false, vertical: true)

                Text(viewModel.headerSubtitle)
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
                .onLongPressGesture(minimumDuration: 0.8) {
                    triggerMorningPlaybackForTesting()
                }
        }
    }

    private func recentRecordSummary(_ record: SessionRecord) -> some View {
        StatusCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                HStack(spacing: AppSpacing.sm) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppColors.successSoft)
                        .frame(width: 28, height: 28)
                        .background(AppColors.successSoft.opacity(colorScheme == .dark ? 0.16 : 0.12))
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                        Text("最近一次守候")
                            .font(AppTypography.headline)
                            .foregroundStyle(AppColors.primaryText(for: colorScheme))

                        Text(recentRecordSubtitle(record))
                            .font(AppTypography.bodySmall)
                            .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                    }

                    Spacer(minLength: AppSpacing.sm)
                }
            }
        }
    }

    private func recentRecordSubtitle(_ record: SessionRecord) -> String {
        let guardedMinutes = max(Int((record.guardedDuration / 60).rounded()), 1)

        if let morningDuration = record.morningPlaybackDuration {
            let morningMinutes = max(Int((morningDuration / 60).rounded()), 1)
            return "昨晚已守候 \(guardedMinutes) 分钟，清晨播放 \(morningMinutes) 分钟"
        }

        return "昨晚已守候 \(guardedMinutes) 分钟"
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
