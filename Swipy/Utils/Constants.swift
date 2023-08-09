//
//  Constants.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import Foundation
import SwiftUI

struct K {
    
    //MARK: - Assets
    static let background = Color("background")
    static let customRed = Color("customRed")
    static let customGreen = Color("customGreen")
    
    //MARK: - Gradients
    
    static func imageBackgroundGradient(mainColor: Color) -> Gradient {
        return Gradient(colors: [mainColor.opacity(0.25), .white.opacity(0)])
    }
    
    //MARK: - Preview Constants
    static let samplePhoto: Photo = Photo(id: "0", alt_description: nil, likes: 0, urls: nil, user: nil)
    
    //MARK: - Grid
    static let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
}
