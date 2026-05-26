//
//  RecordsViewModel.swift
//  SleepAudio
//

import Foundation
import Combine

final class RecordsViewModel: ObservableObject {
    @Published private(set) var records: [SessionRecord] = []

    private let dateFormatter: DateFormatter

    init() {
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_Hans_CN")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }

    func update(records: [SessionRecord]) {
        self.records = records.sorted { $0.sessionDate > $1.sessionDate }
    }

    func dateText(for record: SessionRecord) -> String {
        dateFormatter.string(from: record.sessionDate)
    }

    func guardedDurationText(for record: SessionRecord) -> String {
        durationText(record.guardedDuration)
    }

    func morningDurationText(for record: SessionRecord) -> String {
        guard let duration = record.morningPlaybackDuration else {
            return "清晨播放还在等待记录"
        }

        return "清晨播放 \(durationText(duration))"
    }

    func resultText(for record: SessionRecord) -> String {
        switch record.finalPlaybackState {
        case .paused:
            "声音已自动停止"
        case .fadingIn:
            "清晨声音正在渐入"
        case .playing:
            "清晨声音已经回来"
        case .stopped:
            "清晨播放已停下"
        case .idle:
            "这次记录已安静收好"
        }
    }

    private func durationText(_ interval: TimeInterval) -> String {
        let minutes = max(Int((interval / 60).rounded()), 1)

        if minutes < 60 {
            return "\(minutes) 分钟"
        }

        let hours = minutes / 60
        let remainingMinutes = minutes % 60

        if remainingMinutes == 0 {
            return "\(hours) 小时"
        }

        return "\(hours) 小时 \(remainingMinutes) 分钟"
    }
}
