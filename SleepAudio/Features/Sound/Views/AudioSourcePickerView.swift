//
//  AudioSourcePickerView.swift
//  SleepAudio
//

import SwiftUI

struct AudioSourcePickerView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss

    let sources: [AudioSource]

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    header

                    VStack(spacing: AppSpacing.sm) {
                        ForEach(sources) { source in
                            sourceButton(for: source)
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
        .navigationTitle("默认音频来源")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("选择常用声音")
                .font(AppTypography.title1)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text("这里暂时只保存你的偏好，不会打开或控制真实的音频 App。")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private func sourceButton(for source: AudioSource) -> some View {
        Button {
            appState.updateAudioSource(source)
            dismiss()
        } label: {
            StatusCard {
                HStack(spacing: AppSpacing.md) {
                    Image(systemName: source.symbolName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(AppColors.accentCalmBlue)
                        .frame(width: 42, height: 42)
                        .background(AppColors.accentCalmBlue.opacity(colorScheme == .dark ? 0.16 : 0.12))
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                        Text(source.displayName)
                            .font(AppTypography.headline)
                            .foregroundStyle(AppColors.primaryText(for: colorScheme))

                        Text(source.description)
                            .font(AppTypography.bodySmall)
                            .foregroundStyle(AppColors.secondaryText(for: colorScheme))
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer(minLength: AppSpacing.md)

                    if appState.selectedAudioSource == source {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(AppColors.successSoft)
                    }
                }
            }
        }
        .buttonStyle(.plain)
    }
}

struct AudioSourcePickerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                AudioSourcePickerView(sources: AudioSource.allCases)
            }
            .environmentObject(AppState())
            .previewDisplayName("音频来源选择")

            NavigationStack {
                AudioSourcePickerView(sources: AudioSource.allCases)
            }
            .environmentObject(AppState())
            .preferredColorScheme(.dark)
            .previewDisplayName("音频来源选择 深色")
        }
    }
}
