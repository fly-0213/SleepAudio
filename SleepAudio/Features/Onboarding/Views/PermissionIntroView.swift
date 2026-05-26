//
//  PermissionIntroView.swift
//  SleepAudio
//

import SwiftUI

struct PermissionIntroView: View {
    let backAction: () -> Void
    let completeAction: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xl) {
            header
            permissionCard

            Spacer()

            HStack(spacing: AppSpacing.sm) {
                SecondaryButton(title: "返回", systemImage: "chevron.left", action: backAction)
                PrimaryButton(title: "完成", systemImage: "checkmark", action: completeAction)
            }
        }
        .padding(.horizontal, AppSpacing.pageHorizontal)
        .padding(.top, AppSpacing.xxl)
        .padding(.bottom, AppSpacing.xl)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("之后可能会需要这些权限")
                .font(AppTypography.title1)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text("现在不会弹出系统授权。等真正需要时，我们会先说明原因，再请你决定。")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                .lineSpacing(4)
        }
    }

    private var permissionCard: some View {
        StatusCard {
            VStack(spacing: AppSpacing.md) {
                permissionRow(
                    icon: "applewatch",
                    title: "Apple Watch 状态",
                    message: "用于判断你是否已经安静下来，或早晨是否开始活动。"
                )

                Divider()

                permissionRow(
                    icon: "heart",
                    title: "健康数据",
                    message: "未来会辅助判断入睡和醒来，但不会把复杂数据堆到首页。"
                )

                Divider()

                permissionRow(
                    icon: "bell",
                    title: "通知提醒",
                    message: "只在必要时告诉你声音状态，夜里尽量不打扰。"
                )
            }
        }
    }

    private func permissionRow(
        icon: String,
        title: String,
        message: String
    ) -> some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(AppColors.accentCalmBlue)
                .frame(width: 32, height: 32)
                .background(AppColors.accentCalmBlue.opacity(colorScheme == .dark ? 0.16 : 0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(title)
                    .font(AppTypography.headline)
                    .foregroundStyle(AppColors.primaryText(for: colorScheme))

                Text(message)
                    .font(AppTypography.bodySmall)
                    .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct PermissionIntroView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PermissionIntroView(backAction: {}, completeAction: {})
                .background(AppColors.morningBackground)

            PermissionIntroView(backAction: {}, completeAction: {})
                .background(AppColors.nightBackground)
                .preferredColorScheme(.dark)
        }
    }
}
