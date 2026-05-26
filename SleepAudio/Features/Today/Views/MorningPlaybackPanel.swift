//
//  MorningPlaybackPanel.swift
//  SleepAudio
//

import SwiftUI

struct MorningPlaybackPanel: View {
    let audioSourceName: String
    let playbackState: PlaybackState
    let currentVolume: Double
    let targetVolume: Double
    let progress: Double
    let reduceVolumeAction: () -> Void
    let stopAction: () -> Void
    let dismissAction: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            StatusCard {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    header
                    progressBlock
                    sourceRow
                }
            }

            if playbackState == .stopped {
                SecondaryButton(title: "回到今日", systemImage: "sunrise", action: dismissAction)
            } else {
                HStack(spacing: AppSpacing.sm) {
                    compactButton(title: "再轻一点", systemImage: "speaker.wave.1", action: reduceVolumeAction)
                    compactButton(title: "停止", systemImage: "stop.fill", action: stopAction)
                }
            }
        }
    }

    private var header: some View {
        HStack(alignment: .top, spacing: AppSpacing.sm) {
            Image(systemName: playbackState == .stopped ? "checkmark.circle.fill" : "sunrise.fill")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(playbackState == .stopped ? AppColors.successSoft : AppColors.accentMorning)
                .frame(width: 34, height: 34)
                .background(headerIconBackground)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(title)
                    .font(AppTypography.headline)
                    .foregroundStyle(AppColors.primaryText(for: colorScheme))

                Text(message)
                    .font(AppTypography.bodySmall)
                    .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: AppSpacing.sm)
        }
    }

    private var progressBlock: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            HStack {
                Text("模拟音量")
                    .font(AppTypography.bodySmall)
                    .foregroundStyle(AppColors.secondaryText(for: colorScheme))

                Spacer()

                Text(volumeText)
                    .font(AppTypography.headline)
                    .foregroundStyle(AppColors.primaryText(for: colorScheme))
            }

            ProgressView(value: progress)
                .tint(AppColors.accentMorning)
                .animation(.easeInOut(duration: 0.22), value: progress)

            Text("目标音量：\(percentageText(for: targetVolume))")
                .font(AppTypography.caption)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
        }
    }

    private var sourceRow: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: "waveform")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(AppColors.accentCalmBlue)
                .frame(width: 28, height: 28)
                .background(AppColors.accentCalmBlue.opacity(colorScheme == .dark ? 0.16 : 0.12))
                .clipShape(Circle())

            Text("当前播放来源")
                .font(AppTypography.bodySmall)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))

            Spacer()

            Text(audioSourceName)
                .font(AppTypography.headline)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))
        }
    }

    private func compactButton(
        title: String,
        systemImage: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.xs) {
                Image(systemName: systemImage)
                    .font(.system(size: 15, weight: .semibold))

                Text(title)
                    .font(AppTypography.headline)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundStyle(AppColors.primaryText(for: colorScheme))
            .background(compactButtonBackground)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.xl, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private var title: String {
        switch playbackState {
        case .fadingIn:
            "正在轻柔播放"
        case .playing:
            "声音已经轻轻回来"
        case .stopped:
            "今天早晨已停下"
        case .idle, .paused:
            "早晨声音已准备好"
        }
    }

    private var message: String {
        switch playbackState {
        case .fadingIn:
            "音量将逐渐增大，不会突然把你吵醒。"
        case .playing:
            "房间里已经有一点声音了，慢慢醒来就好。"
        case .stopped:
            "今天不会再自动开始播放。"
        case .idle, .paused:
            "需要时可以再次开始。"
        }
    }

    private var volumeText: String {
        percentageText(for: currentVolume)
    }

    private var headerIconBackground: Color {
        playbackState == .stopped
            ? AppColors.successSoft.opacity(colorScheme == .dark ? 0.16 : 0.12)
            : AppColors.accentMorning.opacity(colorScheme == .dark ? 0.20 : 0.16)
    }

    private var compactButtonBackground: Color {
        colorScheme == .dark
            ? AppColors.primaryTextDark.opacity(0.08)
            : AppColors.primaryTextLight.opacity(0.06)
    }

    private func percentageText(for value: Double) -> String {
        "\(Int((value * 100).rounded()))%"
    }
}

struct MorningPlaybackPanel_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MorningPlaybackPanel(
                audioSourceName: "Spotify",
                playbackState: .fadingIn,
                currentVolume: 0.18,
                targetVolume: 0.35,
                progress: 0.51,
                reduceVolumeAction: {},
                stopAction: {},
                dismissAction: {}
            )
            .padding()
            .background(AppColors.morningBackground)
            .previewDisplayName("晨间播放")

            MorningPlaybackPanel(
                audioSourceName: "播客",
                playbackState: .stopped,
                currentVolume: 0,
                targetVolume: 0.30,
                progress: 0,
                reduceVolumeAction: {},
                stopAction: {},
                dismissAction: {}
            )
            .padding()
            .background(AppColors.nightBackground)
            .preferredColorScheme(.dark)
            .previewDisplayName("晨间播放 已停止")
        }
    }
}
