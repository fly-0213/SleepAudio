//
//  TodayViewModel.swift
//  SleepAudio
//

import Foundation
import Combine

final class TodayViewModel: ObservableObject {
    @Published private(set) var mode: AppMode
    @Published private(set) var isSleepIntentActive = false

    init(date: Date = Date(), calendar: Calendar = .current) {
        mode = AppMode(date: date, calendar: calendar)
    }

    func startSleepIntentPreview() {
        isSleepIntentActive = true
    }

    var primaryButtonTitle: String {
        isSleepIntentActive ? "已进入夜间准备" : "我要睡了"
    }

    var primaryButtonIcon: String {
        isSleepIntentActive ? "checkmark" : "moon.zzz"
    }
}
