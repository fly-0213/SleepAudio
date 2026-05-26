//
//  MockSleepDetectionService.swift
//  SleepAudio
//

import Foundation

struct MockSleepDetectionService: SleepDetecting {
    var delayInSeconds: UInt64 = 7

    func waitForLikelySleep(in session: SleepSession) async throws -> SleepDetectionState {
        try await Task.sleep(nanoseconds: delayInSeconds * 1_000_000_000)
        return .likelyAsleep
    }
}
