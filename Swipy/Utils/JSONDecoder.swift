//
//  JSONDecoder.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import Foundation

func decode<T: Codable> (data: Data) -> T {
    let decoder = JSONDecoder()
    
    do {
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    } catch {
        fatalError("Could not decode data from API")
    }
}
