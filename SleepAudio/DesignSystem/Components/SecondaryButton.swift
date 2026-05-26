//
//  SecondaryButton.swift
//  SleepAudio
//

import SwiftUI

struct SecondaryButton: View {
    let title: String
    var systemImage: String?
    var action: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.xs) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 15, weight: .semibold))
                }

                Text(title)
                    .font(AppTypography.headline)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundStyle(AppColors.primaryText(for: colorScheme))
            .background(secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.xl, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private var secondaryBackground: Color {
        colorScheme == .dark
            ? AppColors.primaryTextDark.opacity(0.08)
            : AppColors.primaryTextLight.opacity(0.06)
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                SecondaryButton(title: "再轻一点", systemImage: "speaker.wave.1") {}
            }
            .padding()
            .background(AppColors.morningBackground)
            .previewDisplayName("次按钮")

            VStack {
                SecondaryButton(title: "停止", systemImage: "stop.fill") {}
            }
            .padding()
            .background(AppColors.nightBackground)
            .preferredColorScheme(.dark)
            .previewDisplayName("次按钮 深色")
        }
    }
}
