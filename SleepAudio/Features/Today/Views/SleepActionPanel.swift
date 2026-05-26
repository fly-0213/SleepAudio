//
//  SleepActionPanel.swift
//  SleepAudio
//

import SwiftUI

struct SleepActionPanel: View {
    let defaultAudioSource: String
    let morningFadeIn: String
    let nightPauseMode: String
    let buttonTitle: String
    let buttonIcon: String
    let action: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            PrimaryButton(title: buttonTitle, systemImage: buttonIcon, action: action)

            StatusCard {
                VStack(spacing: AppSpacing.md) {
                    infoRow(
                        icon: "waveform",
                        title: "默认播放来源",
                        value: defaultAudioSource,
                        color: AppColors.accentCalmBlue
                    )

                    Divider()

                    infoRow(
                        icon: "speaker.wave.2.fill",
                        title: "晨间渐入",
                        value: morningFadeIn,
                        color: AppColors.accentMorning
                    )

                    Divider()

                    infoRow(
                        icon: "moon.zzz.fill",
                        title: "夜间暂停",
                        value: nightPauseMode,
                        color: AppColors.successSoft
                    )
                }
            }
        }
    }

    private func infoRow(
        icon: String,
        title: String,
        value: String,
        color: Color
    ) -> some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 28, height: 28)
                .background(color.opacity(colorScheme == .dark ? 0.16 : 0.12))
                .clipShape(Circle())

            Text(title)
                .font(AppTypography.bodySmall)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))

            Spacer()

            Text(value)
                .font(AppTypography.headline)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))
        }
    }
}

struct SleepActionPanel_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SleepActionPanel(
                defaultAudioSource: "Spotify",
                morningFadeIn: "15 分钟",
                nightPauseMode: "平衡模式",
                buttonTitle: "我要睡了",
                buttonIcon: "moon.zzz"
            ) {}
            .padding()
            .background(AppColors.morningBackground)

            SleepActionPanel(
                defaultAudioSource: "Spotify",
                morningFadeIn: "15 分钟",
                nightPauseMode: "平衡模式",
                buttonTitle: "已进入夜间准备",
                buttonIcon: "checkmark"
            ) {}
            .padding()
            .background(AppColors.nightBackground)
            .preferredColorScheme(.dark)
        }
    }
}
