//
//  ContentView.swift
//  SleepAudio
//
//  Created by F.ly on 5/25/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(AppState())
                .environmentObject(AppRouter())
                .previewDisplayName("Content View")

            ContentView()
                .environmentObject(AppState())
                .environmentObject(AppRouter())
                .preferredColorScheme(.dark)
                .previewDisplayName("Content View Dark")
        }
    }
}
