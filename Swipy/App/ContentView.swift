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
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 10) {
                        ZStack {
                            ForEach(storageManager.photos) { photo in
                                CustomImageView(photo: photo)
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

