//
//  ContentView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import SwiftUI
import RealmSwift


struct ContentView: View {
    
    @EnvironmentObject private var storageManager: StorageManager
    
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Browse")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("History")
                }
        }
        .task {
            storageManager.loadImages(isFirstImage: true)
        }
    }
    
}
#Preview {
    ContentView()
        .environmentObject(StorageManager())
}
