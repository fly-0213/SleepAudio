//
//  PrimaryButton.swift
//  SleepAudio
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var systemImage: String?
    var action: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.xs) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 17, weight: .semibold))
                }

                Text(title)
                    .font(AppTypography.headline)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .foregroundStyle(AppColors.primaryButtonText(for: colorScheme))
            .background(AppColors.primaryButtonBackground(for: colorScheme))
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.xl, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                PrimaryButton(title: "我要睡了", systemImage: "moon.zzz") {}
            }
            .padding()
            .background(AppColors.morningBackground)
            .previewDisplayName("Primary Button")

            VStack {
                PrimaryButton(title: "我要睡了", systemImage: "moon.zzz") {}
            }
            .padding()
            .background(AppColors.nightBackground)
            .preferredColorScheme(.dark)
            .previewDisplayName("Primary Button Dark")
        }
    }
}
