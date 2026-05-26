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
