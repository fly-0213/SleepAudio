//
//  SettingsRow.swift
//  SleepAudio
//

import SwiftUI

struct SettingsRow: View {
    let title: String
    var subtitle: String?
    var systemImage: String?
    var trailingText: String?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack(spacing: AppSpacing.sm) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 28, height: 28)
                    .foregroundStyle(AppColors.accentCalmBlue)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(title)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.primaryText(for: colorScheme))

                if let subtitle {
                    Text(subtitle)
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                }
            }

            Spacer(minLength: AppSpacing.md)

            if let trailingText {
                Text(trailingText)
                    .font(AppTypography.bodySmall)
                    .foregroundStyle(AppColors.secondaryText(for: colorScheme))
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(AppColors.secondaryText(for: colorScheme).opacity(0.7))
        }
        .padding(.vertical, AppSpacing.sm)
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        StatusCard {
            SettingsRow(
                title: "Default sound",
                subtitle: "Used when nothing is already playing",
                systemImage: "waveform",
                trailingText: "Spotify"
            )
        }
        .padding()
        .background(AppColors.morningBackground)
    }
}
