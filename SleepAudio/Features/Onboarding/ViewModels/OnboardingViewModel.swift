//
//  OnboardingViewModel.swift
//  SleepAudio
//

import Foundation
import Combine

final class OnboardingViewModel: ObservableObject {
    enum Step {
        case welcome
        case companionSelection
        case permissionIntro
    }

    @Published private(set) var step: Step = .welcome
    @Published var selectedProfile: CompanionProfile = .female

    func moveForward() {
        switch step {
        case .welcome:
            step = .companionSelection
        case .companionSelection:
            step = .permissionIntro
        case .permissionIntro:
            break
        }
    }

    func moveBackward() {
        switch step {
        case .welcome:
            break
        case .companionSelection:
            step = .welcome
        case .permissionIntro:
            step = .companionSelection
        }
    }
}
