//
//  RecordsView.swift
//  SleepAudio
//

import SwiftUI

struct RecordsView: View {
    @StateObject private var viewModel = RecordsViewModel()
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xl) {
                    header

                    if viewModel.records.isEmpty {
                        emptyState
                    } else {
                        recordsList
                    }
                }
                .padding(.horizontal, AppSpacing.pageHorizontal)
                .padding(.top, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xxl)
            }
        }
        .navigationTitle("记录")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.update(records: appState.sessionRecords)
        }
        .onChange(of: appState.sessionRecords) { _, records in
            viewModel.update(records: records)
        }
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

    private var emptyState: some View {
        StatusCard {
            EmptyStateView(
                systemImage: "clock",
                title: "这里将慢慢记录你的每一个夜晚",
                message: "完成一次夜间守候后，你会看到声音何时停下、早晨又何时回来。",
                accentColor: AppColors.successSoft
            )
        }
    }

    private var recordsList: some View {
        VStack(spacing: AppSpacing.md) {
            ForEach(viewModel.records) { record in
                RecordCardView(
                    record: record,
                    dateText: viewModel.dateText(for: record),
                    guardedDurationText: viewModel.guardedDurationText(for: record),
                    morningDurationText: viewModel.morningDurationText(for: record),
                    resultText: viewModel.resultText(for: record)
                )
            }
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                RecordsView()
            }
            .environmentObject(AppState())

            NavigationStack {
                RecordsView()
            }
            .environmentObject(AppState())
            .preferredColorScheme(.dark)
        }
    }
}
