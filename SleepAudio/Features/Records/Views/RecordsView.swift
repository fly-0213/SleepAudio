//
//  RecordsView.swift
//  SleepAudio
//

import SwiftUI

struct RecordsView: View {
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
                            systemImage: "clock",
                            title: "还没有声音记录",
                            message: "完成一次夜间守候后，你会看到声音何时停下、早晨又何时回来。",
                            accentColor: AppColors.successSoft
                        )
                    }
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
        .navigationTitle("记录")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("记录")
                .font(AppTypography.display)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text("一份安静的记录，留下声音陪伴夜晚的方式。")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText(for: colorScheme))
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                RecordsView()
            }

            NavigationStack {
                RecordsView()
            }
            .preferredColorScheme(.dark)
        }
    }
}
