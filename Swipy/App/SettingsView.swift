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
            if !storageManager.selectedPhotoPresented {
                ScrollView {
                    SettingsImagesGroupView(isExpanded: $likedExpanded, imagesType: .liked)
                    
                    SettingsImagesGroupView(isExpanded: $dislikedExpanded, imagesType: .disliked)
                }
//                .navigationTitle("Profile")
//                .navigationBarTitleDisplayMode(.inline)
                .padding(.top, 25)
                Spacer()
            } else {
                SettingsImageDetailView(photo: storageManager.activeSelectedPhoto ?? K.samplePhoto)
            }
        }
        .padding()
        .onAppear(perform: {
            storageManager.loadPhotos()
        })
        .onDisappear(perform: {
            storageManager.emptyStorage()
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(StorageManager())
    }
}
