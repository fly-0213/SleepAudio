//
//  CompanionCharacterView.swift
//  SleepAudio
//

import SwiftUI

struct CompanionCharacterView: View {
    let mode: AppMode
    let speech: String
    let isResting: Bool

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            speechBubble
            character
        }
    }

    private var speechBubble: some View {
        Text(speech)
            .font(AppTypography.bodySmall)
            .foregroundStyle(AppColors.primaryText(for: colorScheme))
            .padding(.horizontal, AppSpacing.md)
            .padding(.vertical, AppSpacing.xs)
            .background(AppColors.cardBackground(for: colorScheme).opacity(0.88))
            .clipShape(Capsule())
    }

    private var character: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: AppRadius.xl, style: .continuous)
                .fill(characterBaseColor.opacity(colorScheme == .dark ? 0.22 : 0.18))
                .frame(width: 132, height: isResting ? 54 : 22)
                .offset(y: isResting ? 22 : 38)

            VStack(spacing: AppSpacing.xs) {
                Circle()
                    .fill(faceColor)
                    .frame(width: 58, height: 58)
                    .overlay(alignment: .center) {
                        Image(systemName: isResting ? "eyes.inverse" : "face.smiling")
                            .font(.system(size: 22, weight: .regular))
                            .foregroundStyle(AppColors.primaryText(for: colorScheme).opacity(0.74))
                    }

                RoundedRectangle(cornerRadius: AppRadius.lg, style: .continuous)
                    .fill(characterBaseColor.opacity(0.86))
                    .frame(width: 72, height: isResting ? 34 : 80)
                    .overlay(alignment: .top) {
                        Image(systemName: mode.prefersDarkScene ? "moon.zzz.fill" : "music.note")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(AppColors.cardBackground(for: colorScheme).opacity(0.8))
                            .padding(.top, AppSpacing.sm)
                    }
            }
            .rotationEffect(.degrees(isResting ? -4 : 0))
        }
        .frame(height: 170)
    }

    private var faceColor: Color {
        colorScheme == .dark
            ? AppColors.primaryTextDark.opacity(0.82)
            : Color(red: 0.96, green: 0.82, blue: 0.68)
    }

    private var characterBaseColor: Color {
        mode.prefersDarkScene ? AppColors.accentCalmBlue : AppColors.accentMorning
    }
}

struct CompanionCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CompanionCharacterView(mode: .morning, speech: "早上好", isResting: false)
                .padding()
                .background(AppColors.morningBackground)

            CompanionCharacterView(mode: .lateNight, speech: "晚安", isResting: true)
                .padding()
                .background(AppColors.nightBackground)
                .preferredColorScheme(.dark)
        }
    }
}
