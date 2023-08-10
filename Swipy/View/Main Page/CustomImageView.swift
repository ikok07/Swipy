//
//  CustomImageView.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import SwiftUI

struct CustomImageView: View {
    
    @EnvironmentObject private var storageManager: StorageManager
    
    @Binding var messageType: MessageType
    
    @State private var offset: CGSize = CGSize.zero
    @State private var opacity: Double = 1
    @State private var likeOpacity: Double = 0
    @State private var dislikeOpacity: Double = 0
    @State private var gradientColor: Color = Color(red: 0, green: 0, blue: 0)
    
    let feedback = UIImpactFeedbackGenerator(style: .medium)
    
    
    let photo: Photo
    let swipable: Bool
    
    
    func presentMessage(type: MessageType) {
        messageType = type
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.spring()) {
                messageType = .undefined
            }
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: (UIScreen.main.bounds.width) * 0.95, height: (UIScreen.main.bounds.height) * 0.70)
                .foregroundStyle(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            AsyncImage(url: photo.urls?.url) { image in
                image
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                LoadingImagesView()
            }
            
            Image(systemName: "hand.thumbsdown.fill")
                .font(.system(size: 128))
                .foregroundColor(gradientColor.opacity(dislikeOpacity))
            
            Image(systemName: "hand.thumbsup.fill")
                .font(.system(size: 128))
                .foregroundColor(gradientColor.opacity(likeOpacity))
            
            LinearGradient(gradient: K.imageBackgroundGradient(mainColor: gradientColor), startPoint: .bottom, endPoint: .top)
            
            ImageInfoView(photo: photo)
            .padding(.horizontal)
            .padding(.bottom)
        }
        .cornerRadius(12)
        .opacity(opacity)
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    if swipable {
                        offset = gesture.translation
                        if gesture.translation.width > 0 {
                            gradientColor = Color(red: 0, green: Double(gesture.translation.width) / 300, blue: 0)
                            likeOpacity = Double(gesture.translation.width) / 400
                        } else if gesture.translation.width < 0 {
                            gradientColor = Color(red: Double(gesture.translation.width) / -300, green: 0, blue: 0)
                            dislikeOpacity = Double(gesture.translation.width) / -400
                        }
                    }
                }) //: OnChanged
                .onEnded({ gesture in
                    if swipable {
                        if Int(gesture.translation.width) > -150 && Int(gesture.translation.width) < 150 {
                            withAnimation(.spring()) {
                                offset = CGSize.zero
                                gradientColor = Color(red: 0, green: 0, blue: 0)
                                likeOpacity = 0
                                dislikeOpacity = 0
                            }
                        } else if Int(gesture.translation.width) < -150 {
                            withAnimation(.spring(dampingFraction: 1.0)) {
                                offset = CGSize(width: gesture.translation.width - 100, height: gesture.translation.height)
                                opacity = 0
                                storageManager.changeActivePhoto()
                                storageManager.savePhoto(photo, isLiked: false)
                                presentMessage(type: .negative)
                            }
                        } else if Int(gesture.translation.width) > 150 {
                            
                            withAnimation(.spring(dampingFraction: 1.0)) {
                                offset = CGSize(width: gesture.translation.width + 100, height: gesture.translation.height)
                                opacity = 0
                                storageManager.changeActivePhoto()
                                storageManager.savePhoto(photo, isLiked: true)
                                presentMessage(type: .positive)
                            }
                        }
                        feedback.impactOccurred()
                    }
                }) //: OnEnded
        ) //: Gesture
    }
}

struct CustomImageView_Previews: PreviewProvider {

    static var previews: some View {
        CustomImageView(messageType: .constant(.positive), photo: K.samplePhoto, swipable: true)
            .padding(140)
    }
}
