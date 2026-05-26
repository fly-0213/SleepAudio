//
//  SleepActionPanel.swift
//  SleepAudio
//

import SwiftUI

struct SleepActionPanel: View {
    let defaultAudioSource: String
    let morningFadeIn: String
    let nightPauseMode: String
    var statusTitle: String?
    var statusMessage: String?
    var resultTitle: String?
    let buttonTitle: String
    let buttonIcon: String
    var isPrimaryDisabled = false
    var endButtonTitle: String?
    let action: () -> Void
    var endAction: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            PrimaryButton(title: buttonTitle, systemImage: buttonIcon, action: action)
                .disabled(isPrimaryDisabled)
                .opacity(isPrimaryDisabled ? 0.72 : 1)

            if let endButtonTitle, let endAction {
                SecondaryButton(title: endButtonTitle, systemImage: "xmark.circle", action: endAction)
            }

            StatusCard {
                VStack(spacing: AppSpacing.md) {
                    if let resultTitle {
                        resultHeader(title: resultTitle)
                        Divider()
                    } else if let statusTitle, let statusMessage {
                        nightStatus(title: statusTitle, message: statusMessage)
                        Divider()
                    }

                    infoRow(
                        icon: "waveform",
                        title: statusTitle == nil && resultTitle == nil ? "默认播放来源" : "当前播放来源",
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

    private func nightStatus(title: String, message: String) -> some View {
        HStack(alignment: .top, spacing: AppSpacing.sm) {
            Image(systemName: "shield.lefthalf.filled")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(AppColors.successSoft)
                .frame(width: 28, height: 28)
                .background(AppColors.successSoft.opacity(colorScheme == .dark ? 0.16 : 0.12))
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

    private func resultHeader(title: String) -> some View {
        HStack(alignment: .top, spacing: AppSpacing.sm) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(AppColors.successSoft)
                .frame(width: 30, height: 30)

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(title)
                    .font(AppTypography.headline)
                    .foregroundStyle(AppColors.primaryText(for: colorScheme))

                Text("可以安心休息了")
                    .font(AppTypography.bodySmall)
                    .foregroundStyle(AppColors.secondaryText(for: colorScheme))
            }

            Spacer(minLength: AppSpacing.sm)
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
                statusTitle: "正在安静守候",
                statusMessage: "如果你睡着了，我会帮你停下声音。",
                buttonTitle: "守候中",
                buttonIcon: "shield.lefthalf.filled",
                isPrimaryDisabled: true,
                endButtonTitle: "结束守候",
                action: {},
                endAction: {}
            )
            .padding()
            .background(AppColors.nightBackground)
            .preferredColorScheme(.dark)
        }
    }
}
