//
//  ImageModel.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import Foundation
import SwiftUI

struct Photo: Codable, Identifiable {
    let id: String
    let alt_description: String?
    let likes: Int?
    let urls: UrlList?
    let user: UserDetails?
    
    var isLiked: Bool?
}

struct UrlList: Codable {
    let raw: String
    
    var url: URL {
        URL(string: "\(raw)&fit=crop&w=600&h=800")!
    }
    
}

struct UserDetails: Codable {
    let username: String?
    let first_name: String?
    let last_name: String?
    let profile_image: ProfileImages
    let portfolio_url: String?
    
    var fullName: String {
        if let firstName = first_name, let lastName = last_name {
            return firstName + lastName
        }
        return "User with no name"
    }
    
    var portfolioURL: URL? {
        if let portfolioUrl = portfolio_url {
            return URL(string: portfolioUrl)
        } else {
            return nil
        }
    }
}

struct ProfileImages: Codable {
    let medium: String
    
    var url: URL {
        URL(string: medium)!
    }
}
