//
//  CompanionSelectionView.swift
//  SleepAudio
//

import SwiftUI

struct CompanionSelectionView: View {
    @Binding var selectedProfile: CompanionProfile
    let backAction: () -> Void
    let continueAction: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xl) {
            header

            VStack(spacing: AppSpacing.md) {
                companionOption(.female)
                companionOption(.male)
            }

            Spacer()

            HStack(spacing: AppSpacing.sm) {
                SecondaryButton(title: "返回", systemImage: "chevron.left", action: backAction)
                PrimaryButton(title: "继续", systemImage: "arrow.right", action: continueAction)
            }
        }
        .padding(.horizontal, AppSpacing.pageHorizontal)
        .padding(.top, AppSpacing.xxl)
        .padding(.bottom, AppSpacing.xl)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("选择一个陪伴形象")
                .font(AppTypography.title1)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text("它会出现在今日页面，陪你进入夜晚，也陪你迎接早晨。")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
        }
    }

    private func companionOption(_ profile: CompanionProfile) -> some View {
        let isSelected = selectedProfile.style == profile.style

        return Button {
            withAnimation(.easeInOut(duration: 0.18)) {
                selectedProfile = profile
            }
        } label: {
            HStack(spacing: AppSpacing.md) {
                CompanionCharacterView(
                    mode: .morning,
                    profile: profile,
                    speech: profile.style.title,
                    isResting: false
                )
                .frame(width: 116, height: 138)
                .clipped()

                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text(profile.style.title)
                        .font(AppTypography.headline)
                        .foregroundStyle(AppColors.primaryText(for: colorScheme))

                    Text(profile.style.subtitle)
                        .font(AppTypography.bodySmall)
                        .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(isSelected ? AppColors.accentCalmBlue : AppColors.secondaryText(for: colorScheme))
            }
            .padding(AppSpacing.md)
            .background(AppColors.cardBackground(for: colorScheme))
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.lg, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.lg, style: .continuous)
                    .stroke(isSelected ? AppColors.accentCalmBlue : Color.clear, lineWidth: 1.5)
            }
        }
        .buttonStyle(.plain)
    }
}

struct CompanionSelectionView_Previews: PreviewProvider {
    struct PreviewHost: View {
        @State private var selectedProfile = CompanionProfile.female

        var body: some View {
            CompanionSelectionView(
                selectedProfile: $selectedProfile,
                backAction: {},
                continueAction: {}
            )
        }
    }

    static var previews: some View {
        Group {
            PreviewHost()
                .background(AppColors.morningBackground)

            PreviewHost()
                .background(AppColors.nightBackground)
                .preferredColorScheme(.dark)
        }
    }
}
