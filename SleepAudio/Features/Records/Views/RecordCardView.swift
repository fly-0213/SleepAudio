//
//  RecordCardView.swift
//  SleepAudio
//

import SwiftUI

struct RecordCardView: View {
    let record: SessionRecord
    let dateText: String
    let guardedDurationText: String
    let morningDurationText: String
    let resultText: String

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        StatusCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                header
                Divider()
                detailRows
            }
        }
    }

    private var header: some View {
        HStack(alignment: .top, spacing: AppSpacing.sm) {
            Image(systemName: "moon.zzz.fill")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(AppColors.successSoft)
                .frame(width: 34, height: 34)
                .background(AppColors.successSoft.opacity(colorScheme == .dark ? 0.16 : 0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text("昨晚已为你守候")
                    .font(AppTypography.headline)
                    .foregroundStyle(AppColors.primaryText(for: colorScheme))

                Text(dateText)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.secondaryText(for: colorScheme))
            }

            Spacer(minLength: AppSpacing.sm)
        }
    }

    private var detailRows: some View {
        VStack(spacing: AppSpacing.sm) {
            detailRow(
                icon: "checkmark.circle.fill",
                title: resultText,
                value: record.audioSource.displayName,
                color: AppColors.accentCalmBlue
            )

            detailRow(
                icon: "shield.lefthalf.filled",
                title: "守候时长",
                value: guardedDurationText,
                color: AppColors.successSoft
            )

            detailRow(
                icon: "sunrise.fill",
                title: "清晨",
                value: morningDurationText,
                color: AppColors.accentMorning
            )
        }
    }

    private func detailRow(
        icon: String,
        title: String,
        value: String,
        color: Color
    ) -> some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 24, height: 24)

            Text(title)
                .font(AppTypography.bodySmall)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))

            Spacer(minLength: AppSpacing.sm)

            Text(value)
                .font(AppTypography.bodySmall)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))
                .multilineTextAlignment(.trailing)
        }
    }
}

struct RecordCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecordCardView(
            record: .preview,
            dateText: "2026年5月26日",
            guardedDurationText: "42 分钟",
            morningDurationText: "清晨播放 12 分钟",
            resultText: "声音已自动停止"
        )
        .padding()
        .background(AppColors.morningBackground)
    }
}
