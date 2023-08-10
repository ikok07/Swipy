//
//  LikedImagesView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 9.08.23.
//

import SwiftUI

enum ImageType: CaseIterable {
    case liked
    case disliked
}

struct SettingsImagesGroupView: View {
    
    @EnvironmentObject private var storageManager: StorageManager
    @Binding var isExpanded: Bool
    
    let imagesType: ImageType
    
    var body: some View {
        ZStack {
            GroupBox {
                DisclosureGroup(isExpanded: $isExpanded) {
                    LazyVGrid(columns: K.gridLayout, content: {
                        ForEach(imagesType == .liked ? storageManager.savedLikedPhotos : storageManager.savedDislikedPhotos) { photo in
                                AsyncImage(url: photo.urls?.url) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                                storageManager.toggleImageDetails(image: photo)
                                            }
                                        }
                                } placeholder: {
                                    Text("test")
                                }
                        }
                    })
                    .padding(.top, 20)
                } label: {
                    Group {
                        Image(systemName: imagesType == .liked ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                            .foregroundColor(imagesType == .liked ? K.customGreen : K.customRed)
                            .font(.title2)
                        
                        Text(imagesType == .liked ? "Liked Photos" : "Disliked Photos")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                }
                .tint(.black)
            }
        }
    }
}

#Preview {
    SettingsImagesGroupView(isExpanded: .constant(true), imagesType: .disliked)
        .previewLayout(.sizeThatFits)
        .padding()
        .environmentObject(StorageManager())
}
