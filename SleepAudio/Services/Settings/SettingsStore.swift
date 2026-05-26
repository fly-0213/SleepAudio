//
//  SettingsStore.swift
//  SleepAudio
//

import Foundation

final class SettingsStore {
    private enum Key {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let selectedCompanionProfile = "selectedCompanionProfile"
        static let selectedAudioSource = "selectedAudioSource"
        static let morningPlaybackSettings = "morningPlaybackSettings"
        static let nightPauseSettings = "nightPauseSettings"
    }

    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    var hasCompletedOnboarding: Bool {
        get {
            defaults.bool(forKey: Key.hasCompletedOnboarding)
        }
        set {
            defaults.set(newValue, forKey: Key.hasCompletedOnboarding)
        }
    }

    var selectedCompanionProfile: CompanionProfile {
        get {
            guard
                let data = defaults.data(forKey: Key.selectedCompanionProfile),
                let profile = try? decoder.decode(CompanionProfile.self, from: data)
            else {
                return .female
            }

            return profile
        }
        set {
            guard let data = try? encoder.encode(newValue) else { return }
            defaults.set(data, forKey: Key.selectedCompanionProfile)
        }
    }

    var selectedAudioSource: AudioSource {
        get {
            guard
                let rawValue = defaults.string(forKey: Key.selectedAudioSource),
                let source = AudioSource(rawValue: rawValue)
            else {
                return .spotify
            }

            return source
        }
        set {
            defaults.set(newValue.rawValue, forKey: Key.selectedAudioSource)
        }
    }

    var morningPlaybackSettings: MorningPlaybackSettings {
        get {
            loadCodable(
                forKey: Key.morningPlaybackSettings,
                defaultValue: .default
            )
        }
        set {
            saveCodable(newValue, forKey: Key.morningPlaybackSettings)
        }
    }

    var nightPauseSettings: NightPauseSettings {
        get {
            loadCodable(
                forKey: Key.nightPauseSettings,
                defaultValue: .default
            )
        }
        set {
            saveCodable(newValue, forKey: Key.nightPauseSettings)
        }
    }

    func resetOnboardingForDebug() {
        defaults.set(false, forKey: Key.hasCompletedOnboarding)
        defaults.removeObject(forKey: Key.selectedCompanionProfile)
    }

    private func loadCodable<Value: Codable>(
        forKey key: String,
        defaultValue: Value
    ) -> Value {
        guard
            let data = defaults.data(forKey: key),
            let value = try? decoder.decode(Value.self, from: data)
        else {
            return defaultValue
        }

        return value
    }

    private func saveCodable<Value: Codable>(_ value: Value, forKey key: String) {
        guard let data = try? encoder.encode(value) else { return }
        defaults.set(data, forKey: key)
    }
}
