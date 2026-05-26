//
//  SoundSettingsViewModel.swift
//  SleepAudio
//

import Foundation
import Combine

final class SoundSettingsViewModel: ObservableObject {
    let audioSources = AudioSource.allCases
    let fadeInDurations = MorningPlaybackSettings.FadeInDuration.allCases
    let nightPauseTimings = NightPauseSettings.TimingPreference.allCases

    func volumeDisplayName(for volume: Double) -> String {
        "\(Int((volume * 100).rounded()))%"
    }
}
