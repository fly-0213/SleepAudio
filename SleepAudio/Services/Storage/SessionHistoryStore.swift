//
//  SessionHistoryStore.swift
//  SleepAudio
//

import Foundation

final class SessionHistoryStore {
    private enum Key {
        static let sessionRecords = "sessionRecords"
    }

    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func loadRecords() -> [SessionRecord] {
        guard
            let data = defaults.data(forKey: Key.sessionRecords),
            let records = try? decoder.decode([SessionRecord].self, from: data)
        else {
            return []
        }

        return records.sorted { $0.sessionDate > $1.sessionDate }
    }

    func upsert(_ record: SessionRecord) {
        var records = loadRecords()

        if let index = records.firstIndex(where: { $0.id == record.id }) {
            records[index] = record
        } else {
            records.append(record)
        }

        save(records)
    }

    func clearHistory() {
        defaults.removeObject(forKey: Key.sessionRecords)
    }

    private func save(_ records: [SessionRecord]) {
        guard let data = try? encoder.encode(records.sorted(by: { $0.sessionDate > $1.sessionDate })) else {
            return
        }

        defaults.set(data, forKey: Key.sessionRecords)
    }
}
