//
//  SoundSettingsView.swift
//  SleepAudio
//

import SwiftUI

struct SoundSettingsView: View {
    @StateObject private var viewModel = SoundSettingsViewModel()
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    header

                    defaultSourceSection
                    morningSection
                    nightSection
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
        .navigationTitle("声音")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("声音")
                .font(AppTypography.display)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text("选择让房间轻轻响起的声音。")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
        }
    }

    private var defaultSourceSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionTitle("默认来源")

            NavigationLink {
                AudioSourcePickerView(sources: viewModel.audioSources)
            } label: {
                StatusCard {
                    HStack(spacing: AppSpacing.md) {
                        Image(systemName: appState.selectedAudioSource.symbolName)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(AppColors.accentCalmBlue)
                            .frame(width: 46, height: 46)
                            .background(AppColors.accentCalmBlue.opacity(colorScheme == .dark ? 0.16 : 0.12))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                            Text(appState.selectedAudioSource.displayName)
                                .font(AppTypography.headline)
                                .foregroundStyle(AppColors.primaryText(for: colorScheme))

                            Text("没有正在播放的声音时，会优先使用这个来源。")
                                .font(AppTypography.bodySmall)
                                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        Spacer(minLength: AppSpacing.md)

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(AppColors.secondaryText(for: colorScheme).opacity(0.7))
                    }
                }
            }
            .buttonStyle(.plain)
        }
    }

    private var morningSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionTitle("清晨")

            StatusCard {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        settingHeader(
                            title: "晨间渐入时长",
                            subtitle: "醒来时声音会慢慢铺开，不会一下子把房间填满。"
                        )

                        optionGrid {
                            ForEach(viewModel.fadeInDurations) { duration in
                                SoundSettingOptionButton(
                                    title: duration.displayName,
                                    isSelected: appState.morningPlaybackSettings.fadeInDuration == duration
                                ) {
                                    appState.updateMorningFadeInDuration(duration)
                                }
                            }
                        }
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        HStack(alignment: .firstTextBaseline) {
                            settingHeader(
                                title: "目标音量",
                                subtitle: "这里只保存偏好，暂不调整系统音量。"
                            )

                            Spacer(minLength: AppSpacing.md)

                            Text(viewModel.volumeDisplayName(for: appState.morningPlaybackSettings.targetVolume))
                                .font(AppTypography.headline)
                                .foregroundStyle(AppColors.primaryText(for: colorScheme))
                        }

                        Slider(
                            value: Binding(
                                get: { appState.morningPlaybackSettings.targetVolume },
                                set: { appState.updateMorningTargetVolume($0) }
                            ),
                            in: 0.10...1.0,
                            step: 0.05
                        )
                        .tint(AppColors.accentCalmBlue)
                    }
                }
            }
        }
    }

    private var nightSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionTitle("夜晚")

            StatusCard {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    settingHeader(
                        title: "夜间暂停时机",
                        subtitle: "之后会影响手表判断你入睡后的暂停节奏。"
                    )

                    VStack(spacing: AppSpacing.xs) {
                        ForEach(viewModel.nightPauseTimings) { timing in
                            NightPauseTimingOptionView(
                                timing: timing,
                                isSelected: appState.nightPauseSettings.timingPreference == timing
                            ) {
                                appState.updateNightPauseTiming(timing)
                            }
                        }
                    }
                }
            }
        }
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(AppTypography.headline)
            .foregroundStyle(AppColors.primaryText(for: colorScheme))
    }

    private func settingHeader(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.xxs) {
            Text(title)
                .font(AppTypography.headline)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text(subtitle)
                .font(AppTypography.bodySmall)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private func optionGrid<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: AppSpacing.xs),
                GridItem(.flexible(), spacing: AppSpacing.xs)
            ],
            spacing: AppSpacing.xs,
            content: content
        )
    }
}

struct SoundSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                SoundSettingsView()
            }
            .environmentObject(AppState())
            .previewDisplayName("声音设置")

            NavigationStack {
                SoundSettingsView()
            }
            .environmentObject(AppState())
            .preferredColorScheme(.dark)
            .previewDisplayName("声音设置 深色")
        }
    }
}
