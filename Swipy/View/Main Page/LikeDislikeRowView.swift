//
//  LikeDislikeRowView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import SwiftUI

struct LikeDislikeRowView: View {
    var body: some View {
        HStack(spacing: 50) {
            Button {
                
            } label: {
                Image(systemName: "hand.thumbsdown.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(K.customRed)
                    .cornerRadius(10)
            }

            Button {
                
            } label: {
                Image(systemName: "hand.thumbsup.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(K.customGreen)
                    .cornerRadius(10)
            }

        }
    }
}

struct LikeDislikeRowView_Previews: PreviewProvider {
    static var previews: some View {
        LikeDislikeRowView()
    }
}
