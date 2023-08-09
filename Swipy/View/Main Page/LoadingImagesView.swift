//
//  LoadingImagesView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 6.08.23.
//

import SwiftUI

struct LoadingImagesView: View {
    var body: some View {

            VStack {
                Spacer()
                Text("Loading images...")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                ProgressView()
                    .padding(.top)
                    .foregroundColor(.white)
                    .tint(.white)
                Spacer()
            }
            .cornerRadius(12)

    }
}

struct LoadingImagesView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingImagesView()
            .preferredColorScheme(.dark)
    }
}
