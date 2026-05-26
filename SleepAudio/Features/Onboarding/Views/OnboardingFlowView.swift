//
//  OnboardingFlowView.swift
//  SleepAudio
//

import SwiftUI

struct OnboardingFlowView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            AppColors.appBackground(for: colorScheme)
                .ignoresSafeArea()

            currentStep
                .transition(.opacity.combined(with: .move(edge: .trailing)))
        }
        .animation(.easeInOut(duration: 0.24), value: viewModel.step)
    }

    @ViewBuilder
    private var currentStep: some View {
        switch viewModel.step {
        case .welcome:
            WelcomeView {
                viewModel.moveForward()
            }
        case .companionSelection:
            CompanionSelectionView(
                selectedProfile: $viewModel.selectedProfile,
                backAction: {
                    viewModel.moveBackward()
                },
                continueAction: {
                    viewModel.moveForward()
                }
            )
        case .permissionIntro:
            PermissionIntroView(
                backAction: {
                    viewModel.moveBackward()
                },
                completeAction: {
                    appState.completeOnboarding(with: viewModel.selectedProfile)
                }
            )
        }
    }
}

struct OnboardingFlowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingFlowView()
                .environmentObject(AppState())

            OnboardingFlowView()
                .environmentObject(AppState())
                .preferredColorScheme(.dark)
        }
    }
}
