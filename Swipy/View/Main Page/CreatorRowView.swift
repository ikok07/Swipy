//
//  CreatorRowView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import SwiftUI

struct CreatorRowView: View {
    
    let photo: Photo
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Group {
                AsyncImage(url: photo.user?.profile_image.url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                } placeholder: {
                    Rectangle()
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                }
                    
                Text(photo.user?.fullName ?? "No user details")
                    .fontWeight(.bold)
            }
            Spacer()
            if photo.user?.portfolioURL != nil {
                Link(destination: (photo.user?.portfolioURL)!) {
                    Image(systemName: "arrow.up.right.square")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                }
            }

        }
    }
}

struct CreatorRowView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorRowView(photo: K.samplePhoto)
            .padding(.horizontal)
    }
}
