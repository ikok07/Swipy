//
//  SettingsView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 7.08.23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var storageManager: StorageManager
    private var apiManager = ApiManager()
    
    @State private var likedExpanded: Bool = false
    @State private var dislikedExpanded: Bool = false
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    SettingsImagesGroupView(isExpanded: $likedExpanded, imagesType: .liked)
                    
                    SettingsImagesGroupView(isExpanded: $dislikedExpanded, imagesType: .disliked)
                }
                Spacer()
        }
        .navigationTitle("Profile")
        .padding()
        .toolbar {
            Button {
                storageManager.emptyStorage()
            } label: {
                Text("Close")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(StorageManager())
    }
}
