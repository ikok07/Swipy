//
//  StorageManager.swift
//  Swipy
//
//  Created by Kaloyan Petkov on 5.08.23.
//

import Foundation
import RealmSwift


class StorageManager: ObservableObject {
    let apiManager = ApiManager()
    let realm = try! Realm()
    
    @Published var photos: [Photo] = []
    @Published var activePhoto: Photo? = nil
    @Published var savedLikedPhotos: [Photo] = []
    @Published var savedDislikedPhotos: [Photo] = []
    private var standbyPhotos: [Photo] = []
    
    var activePhotoIndex: Int = 0
    
    func loadImages(isFirstImage: Bool = false, isStandby: Bool = false) {
        apiManager.getImages { photos in
            if let safePhotos = photos {
                    DispatchQueue.main.async {
                        self.photos.append(contentsOf: safePhotos)
                        if isFirstImage {
                            self.activePhoto = photos?[self.activePhotoIndex]
                        } else if isStandby {
                            self.standbyPhotos = safePhotos
                    }
                }
                print("Images loaded")
            } else {
                print("No images available")
            }
        }
    }
    
    func changeActivePhoto() {
        activePhotoIndex += 1
        
        if (activePhotoIndex + 5) % 10 == 0 {
            loadImages(isStandby: true)
        } else if (activePhotoIndex + 1) % 10 == 0 {
            let leftTwoImages = Array(photos.prefix(2))
            photos.removeAll()
            photos.append(contentsOf: leftTwoImages)
            photos.append(contentsOf: standbyPhotos)
            activePhotoIndex = 0
        }
        
        activePhoto = photos[activePhotoIndex]
        print("changed photo")
    }
    
    func savePhoto(_ photo: Photo, isLiked: Bool) {
        
        let imageToSave: SavedImage = SavedImage()
        imageToSave.id = photo.id
        imageToSave.liked = isLiked
        
        do {
            try realm.write {
                realm.add(imageToSave)
            }
        } catch {
            print("Could not save photo in database")
        }
        
    }
    
    
    @MainActor func loadPhotos() {
        let photos: [SavedImage] = Array(realm.objects(SavedImage.self))
        
        for image in photos {
            let url = URL(string: "https://api.unsplash.com/photos/\(image.id)?client_id=e4m2bxt9kEx6jttYcyfepms5FwrhD-vO4D5QKAQbN7g&query=nature&w=530&h=800&count=20213")!
            
            Task {
                if var safePhoto = await apiManager.decodeSpecificImageData(url: url) {
                    DispatchQueue.main.async {
                        safePhoto.isLiked = image.liked
                        
                        if safePhoto.isLiked! {
                            self.savedLikedPhotos.append(safePhoto)
                        } else {
                            self.savedDislikedPhotos.append(safePhoto)
                        }
                    }
                }
            }
        }
    }
    
    func emptyStorage() {
        savedLikedPhotos = []
        savedDislikedPhotos = []
    }
}
