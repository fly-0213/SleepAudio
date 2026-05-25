//
//  AppState.swift
//  SleepAudio
//

import Foundation
import Combine

final class AppState: ObservableObject {
    @Published var placeholderStatus = "Tonight's sound is ready"
}
