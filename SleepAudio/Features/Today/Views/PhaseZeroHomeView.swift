//
//  PhaseZeroHomeView.swift
//  SleepAudio
//

import SwiftUI

struct PhaseZeroHomeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    header
                    scene
                    statusCards
                    PrimaryButton(title: "我要睡了", systemImage: "moon.zzz") {}
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            HStack {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("今天")
                        .font(AppTypography.display)
                        .foregroundStyle(AppColors.primaryText(for: colorScheme))

                    Text(appState.placeholderStatus)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                }

                Spacer()

                Image(systemName: "applewatch")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(AppColors.accentCalmBlue)
                    .frame(width: 44, height: 44)
                    .background(AppColors.cardBackground(for: colorScheme))
                    .clipShape(Circle())
            }
        }
    }

    private var scene: some View {
        SceneCard {
            ZStack {
                Circle()
                    .fill(AppColors.accentMorning.opacity(colorScheme == .dark ? 0.28 : 0.9))
                    .frame(width: 78, height: 78)
                    .blur(radius: colorScheme == .dark ? 10 : 4)
                    .offset(x: 88, y: -86)

                VStack(spacing: AppSpacing.md) {
                    Image(systemName: colorScheme == .dark ? "moon.stars.fill" : "sun.max.fill")
                        .font(.system(size: 46, weight: .regular))
                        .foregroundStyle(colorScheme == .dark ? AppColors.accentMoon : AppColors.accentMorning)

                    Image(systemName: "figure.and.child.holdinghands")
                        .font(.system(size: 58, weight: .regular))
                        .foregroundStyle(AppColors.primaryText(for: colorScheme).opacity(0.78))

                    Text(colorScheme == .dark ? "今晚交给我吧" : "声音会轻轻回来")
                        .font(AppTypography.headline)
                        .foregroundStyle(AppColors.primaryText(for: colorScheme))
                        .padding(.horizontal, AppSpacing.md)
                        .padding(.vertical, AppSpacing.xs)
                        .background(AppColors.cardBackground(for: colorScheme).opacity(0.86))
                        .clipShape(Capsule())
                }
            }
        }
    }

    private var statusCards: some View {
        VStack(spacing: AppSpacing.sm) {
            StatusCard {
                HStack {
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text("今晚声音")
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                        Text("Spotify")
                            .font(AppTypography.headline)
                            .foregroundStyle(AppColors.primaryText(for: colorScheme))
                    }

                    Spacer()

                    Image(systemName: "waveform")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(AppColors.accentCalmBlue)
                }
            }

            StatusCard {
                HStack {
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text("明早声音")
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                        Text("轻柔渐入至 35%")
                            .font(AppTypography.headline)
                            .foregroundStyle(AppColors.primaryText(for: colorScheme))
                    }

                    Spacer()

                    Image(systemName: "speaker.wave.2.fill")
                        .font(.system(size: 21, weight: .medium))
                        .foregroundStyle(AppColors.accentMorning)
                }
            }
        }
    }
}

struct PhaseZeroHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PhaseZeroHomeView()
                .environmentObject(AppState())
                .previewDisplayName("Phase 0 Home")

            PhaseZeroHomeView()
                .environmentObject(AppState())
                .preferredColorScheme(.dark)
                .previewDisplayName("Phase 0 Home Dark")
        }
    }
}
