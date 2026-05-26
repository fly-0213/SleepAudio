//
//  SoundSettingOptionButton.swift
//  SleepAudio
//

import SwiftUI

struct SoundSettingOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTypography.bodySmall)
                .foregroundStyle(textColor)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private var background: Color {
        if isSelected {
            return colorScheme == .dark
                ? AppColors.accentCalmBlue.opacity(0.24)
                : AppColors.accentCalmBlue.opacity(0.18)
        }

        return colorScheme == .dark
            ? AppColors.primaryTextDark.opacity(0.06)
            : AppColors.primaryTextLight.opacity(0.05)
    }

    private var textColor: Color {
        isSelected
            ? AppColors.primaryText(for: colorScheme)
            : AppColors.secondaryText(for: colorScheme)
    }
}

struct NightPauseTimingOptionView: View {
    let timing: NightPauseSettings.TimingPreference
    let isSelected: Bool
    let action: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.sm) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(isSelected ? AppColors.successSoft : AppColors.secondaryText(for: colorScheme).opacity(0.6))

                VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                    Text(timing.displayName)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.primaryText(for: colorScheme))

                    Text(timing.description)
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: AppSpacing.sm)
            }
            .padding(AppSpacing.sm)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private var background: Color {
        if isSelected {
            return colorScheme == .dark
                ? AppColors.accentCalmBlue.opacity(0.24)
                : AppColors.accentCalmBlue.opacity(0.18)
        }

        return colorScheme == .dark
            ? AppColors.primaryTextDark.opacity(0.06)
            : AppColors.primaryTextLight.opacity(0.05)
    }
}

struct SoundSettingOptionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: AppSpacing.sm) {
            SoundSettingOptionButton(title: "15 分钟", isSelected: true) {}
            NightPauseTimingOptionView(timing: .balanced, isSelected: true) {}
        }
        .padding()
        .background(AppColors.morningBackground)
        .previewDisplayName("声音选项按钮")
    }
}
