//
//  HomePageView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 10.08.23.
//

import SwiftUI
import RealmSwift

struct HomePageView: View {
    
    let realm = try! Realm()
    
    @EnvironmentObject private var storageManager: StorageManager
    
    @State var isPresented: Bool = false
    @State private var messageType: MessageType = .undefined
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                if messageType == .positive {
                    MessageView(type: .positive)
                        .zIndex(2)
                        .opacity(0.75)
                } else if messageType == .negative {
                    MessageView(type: .negative)
                        .zIndex(2)
                        .opacity(0.75)
                }
                
                
                VStack(spacing: 10) {
                        ZStack {
                            ForEach(storageManager.photos) { photo in
                                CustomImageView(messageType: $messageType, photo: photo, swipable: true)
                            }
                        }
                    
                        Spacer()
                        
                    CreatorRowView(photo: storageManager.activePhoto ?? K.samplePhoto)
                        
                    } //: VStack
                    .padding()
                } //: ZStack
                .padding()
                .background {
                    K.background
                        .ignoresSafeArea(.all)
                }
            } //: NavigationStack
    }
}

#Preview {
    HomePageView()
        .environmentObject(StorageManager())
}
