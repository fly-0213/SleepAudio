//
//  TodayView.swift
//  SleepAudio
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        PhaseZeroHomeView()
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                TodayView()
            }
            .environmentObject(AppState())

            NavigationStack {
                TodayView()
            }
            .environmentObject(AppState())
            .preferredColorScheme(.dark)
        }
    }
}
