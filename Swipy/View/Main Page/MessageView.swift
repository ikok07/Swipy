//
//  MessageView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 9.08.23.
//

import SwiftUI

enum MessageType: CaseIterable {
    case positive
    case negative
    case undefined
}

struct MessageView: View {
    
    let type: MessageType
    
    var body: some View {
        HStack {
            Image(systemName: type == .positive ? "checkmark.circle.fill" : "x.circle.fill")
            
            Text(type == .positive ? "Liked" : "Didn't like")
                .fontWeight(.bold)
        }
        .foregroundStyle(.white)
        .frame(width: 250, height: 50)
        .background(type == .positive ? K.customGreen : K.customRed)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MessageView(type: .positive)
}
