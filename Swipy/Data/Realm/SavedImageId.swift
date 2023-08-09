//
//  SavedImageId.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 7.08.23.
//

import Foundation
import RealmSwift

class SavedImage: Object {
    @Persisted var id: String
    @Persisted var liked: Bool
}
