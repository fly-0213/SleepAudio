//
//  DayNightSceneView.swift
//  SleepAudio
//

import SwiftUI

struct DayNightSceneView: View {
    let mode: AppMode
    let companionProfile: CompanionProfile
    let companionSpeech: String
    let isResting: Bool

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            background
            ambientLight
            symbol
            CompanionCharacterView(
                mode: mode,
                profile: companionProfile,
                speech: companionSpeech,
                isResting: isResting
            )
            .offset(y: 30)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 320)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.xl, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: AppRadius.xl, style: .continuous)
                .stroke(borderColor, lineWidth: 1)
        }
    }

    private var background: some View {
        LinearGradient(
            colors: mode.sceneColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var ambientLight: some View {
        Circle()
            .fill(mode.accentColor.opacity(mode.prefersDarkScene ? 0.22 : 0.42))
            .frame(width: 150, height: 150)
            .blur(radius: 18)
            .offset(x: 94, y: -92)
    }

    private var symbol: some View {
        Image(systemName: mode.sceneSymbol)
            .font(.system(size: 54, weight: .regular))
            .foregroundStyle(mode.prefersDarkScene ? AppColors.accentMoon : mode.accentColor)
            .shadow(color: mode.accentColor.opacity(0.25), radius: 14, x: 0, y: 8)
            .offset(x: 92, y: -92)
    }

    private var borderColor: Color {
        colorScheme == .dark
            ? AppColors.primaryTextDark.opacity(0.06)
            : Color.white.opacity(0.72)
    }
}

struct DayNightSceneView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DayNightSceneView(
                mode: .morning,
                companionProfile: .female,
                companionSpeech: "早上好",
                isResting: false
            )
                .padding()
                .background(AppColors.morningBackground)

            DayNightSceneView(
                mode: .lateNight,
                companionProfile: .male,
                companionSpeech: "我会安静陪着你",
                isResting: false
            )
                .padding()
                .background(AppColors.nightBackground)
                .preferredColorScheme(.dark)
        }
    }
}
