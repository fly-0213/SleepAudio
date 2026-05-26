//
//  SettingsView.swift
//  SleepAudio
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    header
                    settingsPlaceholder
                    emptyState
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
        .navigationTitle("设置")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("设置")
                .font(AppTypography.display)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text("让体验保持安静，也更贴近你。")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
        }
    }

    private var settingsPlaceholder: some View {
        StatusCard {
            VStack(spacing: 0) {
                SettingsRow(
                    title: "陪伴形象",
                    subtitle: "外观与语气",
                    systemImage: "person.crop.circle",
                    trailingText: "稍后"
                )

                Divider()
                    .padding(.leading, 40)

                SettingsRow(
                    title: "Apple Watch",
                    subtitle: "连接与权限",
                    systemImage: "applewatch",
                    trailingText: "模拟"
                )
            }
        }
    }

    private var emptyState: some View {
        StatusCard {
            EmptyStateView(
                systemImage: "gearshape",
                title: "设置会慢慢长出来",
                message: "陪伴形象、权限说明和温和的误触发保护，之后都会放在这里。",
                accentColor: AppColors.accentMorning
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                SettingsView()
            }

            NavigationStack {
                SettingsView()
            }
            .preferredColorScheme(.dark)
        }
    }
}
