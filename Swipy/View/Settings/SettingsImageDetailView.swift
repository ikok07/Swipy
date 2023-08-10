//
//  SettingsImageDetail.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 10.08.23.
//

import SwiftUI

struct SettingsImageDetailView: View {
    @EnvironmentObject private var storageManager: StorageManager
    
    
    let photo: Photo
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    CustomImageView(messageType: .constant(.positive), photo: photo, swipable: false)
                    
                    CreatorRowView(photo: photo)
                }
                .frame(height: (UIScreen.main.bounds.height) * 0.70)
                .padding(.horizontal)
                .toolbar {
                    Button(action: {
                        withAnimation(.linear) {
                            storageManager.toggleImageDetails()
                        }
                    }, label: {
                        Text("Back")
                    })
                }
            }
        }
    }
}

#Preview {
    SettingsImageDetailView(photo: K.samplePhoto)
        .environmentObject(StorageManager())
}
