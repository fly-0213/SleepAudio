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
                            title: "No sound records yet",
                            message: "After a night session, you will see when sound paused and when morning audio returned.",
                            accentColor: AppColors.successSoft
                        )
                    }
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
        .navigationTitle("Records")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("Records")
                .font(AppTypography.display)
                .foregroundStyle(AppColors.primaryText(for: colorScheme))

            Text("A quiet log of how sound cared for your night.")
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
