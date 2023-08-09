//
//  ContentView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import SwiftUI
import RealmSwift


struct ContentView: View {
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
                        .offset(y: -40)
                } else if messageType == .negative {
                    MessageView(type: .negative)
                        .zIndex(2)
                        .opacity(0.75)
                        .offset(y: -40)
                }
                
                
                VStack(spacing: 10) {
                        ZStack {
                            ForEach(storageManager.photos) { photo in
                                CustomImageView(messageType: $messageType, photo: photo)
                            }
                        }
                    
                        Spacer()
                        
                    CreatorRowView(photo: storageManager.activePhoto ?? K.samplePhoto)
                        
                    } //: VStack
                    .padding()
                    .toolbar {
                        Button {
                            storageManager.loadPhotos()
                            isPresented = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.accentColor)
                        }
                        
                    } //: Toolbar
                } //: ZStack
                .padding()
                .background {
                    K.background
                        .ignoresSafeArea(.all)
                }
                .onAppear {
                    storageManager.loadImages(isFirstImage: true)
                }
                .sheet(isPresented: $isPresented,
                       onDismiss: {
                            storageManager.emptyStorage()
                        }
                    )
                    {
                        SettingsView()
                    }
                
            } //: NavigationStack
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(StorageManager())
        }
    }

