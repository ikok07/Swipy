//
//  ImageInfoFirstRowView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 6.08.23.
//

import SwiftUI

struct ImageInfoView: View {
    
    let photo: Photo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            HStack {
                Text(photo.user?.username ?? "No username")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                    
                    Text("\(photo.likes ?? 0) likes")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                } //: Hstack
                
            } //: HStack
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Info".uppercased())
                    .foregroundColor(.white.opacity(0.3))
                    .fontWeight(.bold)
                
                Text(photo.alt_description ?? "No description")
                    .foregroundColor(.white)
                    .font(.subheadline)
            } //: VStack
        }
    }
    
    struct ImageInfoFirstRowView_Previews: PreviewProvider {
        static var previews: some View {
            ImageInfoView(photo: K.samplePhoto)
                .preferredColorScheme(.dark)
                .padding(.horizontal)
        }
        
    }
}
