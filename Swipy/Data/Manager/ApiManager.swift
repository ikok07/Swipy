//
//  ApiManager.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import Foundation
import SwiftUI

class ApiManager {
    
    let randomImageUrl: URL = URL(string: "https://api.unsplash.com/photos/random?client_id=e4m2bxt9kEx6jttYcyfepms5FwrhD-vO4D5QKAQbN7g&query=nature&w=530&h=800&count=10")!
    
    func decodeRandomImageData(completion: @escaping ([Photo]?) -> Void) {
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: randomImageUrl)
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                fatalError("There was an error connecting to the API: \(error!)")
            }
            
            guard let data = data else {
                fatalError("There was no data from API")
            }
            let result: [Photo] = decode(data: data)
            completion(result)
        }
        task.resume()
    }
    
    
    func decodeSpecificImageData(url: URL) async -> Photo? {
        
        let fetchTask = Task { () -> Photo in
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Photo.self, from: data)
            return decodedData
        }
        
        let result = await fetchTask.result
        switch result {
        case .success(let photo):
            return photo
        case .failure(let error):
            print("Failed decoding images: \(error)")
            return nil
        }
    }
    
    
    func getImages(completion: @escaping ([Photo]?) -> Void) {
        decodeRandomImageData { photos in
            completion(photos)
        }
    }
    
}
