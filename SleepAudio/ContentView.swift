//
//  ContentView.swift
//  SleepAudio
//
//  Created by F.ly on 5/25/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PhaseZeroHomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(AppState())
                .previewDisplayName("Content View")

            ContentView()
                .environmentObject(AppState())
                .preferredColorScheme(.dark)
                .previewDisplayName("Content View Dark")
        }
    }
}
