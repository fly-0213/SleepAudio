//
//  StatusCard.swift
//  SleepAudio
//

import SwiftUI

struct StatusCard<Content: View>: View {
    @ViewBuilder var content: Content

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(AppSpacing.md)
            .background(AppColors.cardBackground(for: colorScheme))
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.lg, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.lg, style: .continuous)
                    .stroke(cardStroke, lineWidth: 1)
            }
            .shadow(color: shadowColor, radius: 18, x: 0, y: 8)
    }

    private var cardStroke: Color {
        colorScheme == .dark
            ? AppColors.primaryTextDark.opacity(0.06)
            : Color.black.opacity(0.03)
    }

    private var shadowColor: Color {
        colorScheme == .dark ? .clear : Color.black.opacity(0.06)
    }
}

struct StatusCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatusCard {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("今晚声音")
                        .font(AppTypography.caption)
                    Text("Spotify")
                        .font(AppTypography.headline)
                }
            }
            .padding()
            .background(AppColors.morningBackground)
            .previewDisplayName("Status Card")

            StatusCard {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("正在安静守候")
                        .font(AppTypography.headline)
                    Text("等你睡着后，我会停下声音")
                        .font(AppTypography.bodySmall)
                }
                .foregroundStyle(AppColors.primaryTextDark)
            }
            .padding()
            .background(AppColors.nightBackground)
            .preferredColorScheme(.dark)
            .previewDisplayName("Status Card Dark")
        }
    }
}
