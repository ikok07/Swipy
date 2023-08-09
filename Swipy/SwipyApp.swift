//
//  SwipyApp.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import SwiftUI

@main
struct SwipyApp: App {
    
    @ObservedObject var storageManager = StorageManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storageManager)
        }
    }
}
