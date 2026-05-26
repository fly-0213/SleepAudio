//
//  SleepDetecting.swift
//  SleepAudio
//

import Foundation

protocol SleepDetecting {
    func waitForLikelySleep(in session: SleepSession) async throws -> SleepDetectionState
}
