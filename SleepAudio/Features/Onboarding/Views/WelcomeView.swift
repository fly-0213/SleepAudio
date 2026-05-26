//
//  WelcomeView.swift
//  SleepAudio
//

import SwiftUI

struct WelcomeView: View {
    let action: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: AppSpacing.xxl) {
            Spacer(minLength: AppSpacing.xxl)

            DayNightSceneView(
                mode: .evening,
                companionProfile: .female,
                companionSpeech: "欢迎来到这里",
                isResting: false
            )
            .frame(height: 300)

            VStack(spacing: AppSpacing.md) {
                Text("让声音陪你入睡，也陪你醒来")
                    .font(AppTypography.title1)
                    .foregroundStyle(AppColors.primaryText(for: colorScheme))
                    .multilineTextAlignment(.center)

                Text("晚上不用反复设置倒计时，早晨也不用急着摸手机。它会安静地记住你的声音习惯。")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }

            Spacer()

            PrimaryButton(title: "开始设置", systemImage: "sparkles", action: action)
        }
        .padding(.horizontal, AppSpacing.pageHorizontal)
        .padding(.bottom, AppSpacing.xl)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView {}
                .background(AppColors.morningBackground)

            WelcomeView {}
                .background(AppColors.nightBackground)
                .preferredColorScheme(.dark)
        }
    }
}
