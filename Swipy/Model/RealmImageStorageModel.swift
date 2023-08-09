//
//  RealmImageStorageModel.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 7.08.23.
//

import Foundation
import RealmSwift


class RealmImageStorage: Object {
    @Persisted var likedPhotos: [Photo]
}
