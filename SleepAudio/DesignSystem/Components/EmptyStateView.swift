//
//  EmptyStateView.swift
//  SleepAudio
//

import SwiftUI

struct EmptyStateView: View {
    let systemImage: String
    let title: String
    let message: String
    var accentColor: Color = AppColors.accentCalmBlue

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            Image(systemName: systemImage)
                .font(.system(size: 34, weight: .medium))
                .foregroundStyle(accentColor)
                .frame(width: 76, height: 76)
                .background(accentColor.opacity(colorScheme == .dark ? 0.16 : 0.12))
                .clipShape(Circle())

            VStack(spacing: AppSpacing.xs) {
                Text(title)
                    .font(AppTypography.title2)
                    .foregroundStyle(AppColors.primaryText(for: colorScheme))
                    .multilineTextAlignment(.center)

                Text(message)
                    .font(AppTypography.bodySmall)
                    .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.xxl)
        .padding(.horizontal, AppSpacing.lg)
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyStateView(
                systemImage: "waveform",
                title: "Sound settings are waiting",
                message: "Your default evening and morning audio source will live here."
            )
            .padding()
            .background(AppColors.morningBackground)
            .previewDisplayName("Empty State")

            EmptyStateView(
                systemImage: "moon.stars",
                title: "Quietly ready",
                message: "This state keeps the interface calm before real content arrives."
            )
            .padding()
            .background(AppColors.nightBackground)
            .preferredColorScheme(.dark)
            .previewDisplayName("Empty State Dark")
        }
    }
}
