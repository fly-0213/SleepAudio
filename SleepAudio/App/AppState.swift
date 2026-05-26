//
//  AppState.swift
//  SleepAudio
//

import Foundation
import Combine

final class AppState: ObservableObject {
    @Published var placeholderStatus = "今晚的声音已经准备好"
    @Published private(set) var hasCompletedOnboarding: Bool
    @Published private(set) var selectedCompanionProfile: CompanionProfile
    @Published private(set) var selectedAudioSource: AudioSource
    @Published private(set) var morningPlaybackSettings: MorningPlaybackSettings
    @Published private(set) var nightPauseSettings: NightPauseSettings
    @Published private(set) var sessionRecords: [SessionRecord]

    private let settingsStore: SettingsStore
    private let sessionHistoryStore: SessionHistoryStore

    init(
        settingsStore: SettingsStore = SettingsStore(),
        sessionHistoryStore: SessionHistoryStore = SessionHistoryStore()
    ) {
        self.settingsStore = settingsStore
        self.sessionHistoryStore = sessionHistoryStore
        hasCompletedOnboarding = settingsStore.hasCompletedOnboarding
        selectedCompanionProfile = settingsStore.selectedCompanionProfile
        selectedAudioSource = settingsStore.selectedAudioSource
        morningPlaybackSettings = settingsStore.morningPlaybackSettings
        nightPauseSettings = settingsStore.nightPauseSettings
        sessionRecords = sessionHistoryStore.loadRecords()
    }

    func selectCompanionProfile(_ profile: CompanionProfile) {
        selectedCompanionProfile = profile
        settingsStore.selectedCompanionProfile = profile
    }

    func completeOnboarding(with profile: CompanionProfile) {
        selectCompanionProfile(profile)
        hasCompletedOnboarding = true
        settingsStore.hasCompletedOnboarding = true
    }

    func resetOnboardingForDebug() {
        settingsStore.resetOnboardingForDebug()
        hasCompletedOnboarding = false
        selectedCompanionProfile = settingsStore.selectedCompanionProfile
    }

    func updateAudioSource(_ source: AudioSource) {
        selectedAudioSource = source
        settingsStore.selectedAudioSource = source
    }

    func updateMorningFadeInDuration(_ duration: MorningPlaybackSettings.FadeInDuration) {
        morningPlaybackSettings.fadeInDuration = duration
        settingsStore.morningPlaybackSettings = morningPlaybackSettings
    }

    func updateMorningTargetVolume(_ volume: Double) {
        let clampedVolume = min(max(volume, 0.10), 1.0)
        morningPlaybackSettings.targetVolume = clampedVolume
        settingsStore.morningPlaybackSettings = morningPlaybackSettings
    }

    func updateNightPauseTiming(_ timing: NightPauseSettings.TimingPreference) {
        nightPauseSettings.timingPreference = timing
        settingsStore.nightPauseSettings = nightPauseSettings
    }

    var latestSessionRecord: SessionRecord? {
        sessionRecords.first
    }

    func upsertSessionRecord(_ record: SessionRecord) {
        sessionHistoryStore.upsert(record)
        sessionRecords = sessionHistoryStore.loadRecords()
    }

    func clearSessionHistoryForDebug() {
        sessionHistoryStore.clearHistory()
        sessionRecords = []
    }
}
