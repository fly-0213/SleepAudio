//
//  SoundSettingsView.swift
//  SleepAudio
//

import SwiftUI

struct SoundSettingsView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    header

                    StatusCard {
                        EmptyStateView(
                            systemImage: "waveform",
                            title: "声音设置还在等待",
                            message: "默认音频来源、晨间渐入和夜间暂停偏好，之后都会放在这里。",
                            accentColor: AppColors.accentCalmBlue
                        )
                    }
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
        .navigationTitle("声音")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("声音")
                .font(AppTypography.display)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text("选择让房间轻轻响起的声音。")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
        }
    }
}

struct SoundSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                SoundSettingsView()
            }

            NavigationStack {
                SoundSettingsView()
            }
            .preferredColorScheme(.dark)
        }
    }
}
