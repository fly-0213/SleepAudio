//
//  SceneCard.swift
//  SleepAudio
//

import SwiftUI

struct SceneCard<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppRadius.xl, style: .continuous)
                .fill(sceneGradient)

            content
                .padding(AppSpacing.lg)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.xl, style: .continuous))
    }

    private var sceneGradient: LinearGradient {
        LinearGradient(
            colors: [
                AppColors.accentCalmBlue.opacity(0.35),
                AppColors.accentMorning.opacity(0.26),
                AppColors.morningBackground
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

struct SceneCard_Previews: PreviewProvider {
    static var previews: some View {
        SceneCard {
            Text("日夜场景")
                .font(AppTypography.title2)
        }
        .padding()
        .background(AppColors.morningBackground)
    }
}
