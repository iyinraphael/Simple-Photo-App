//
//  PhotoController.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation
import CoreData

 let moc = CoreDataStack.shared.mainContext

class PhotoController {
    

    
    var photos =  Array<PhotoRepresentation>()
    var savePhotos = Array<Photo>()
    typealias completionHandler = ([PhotoRepresentation]?,Error?) -> Void
    
    func savePhoto(title: String, photoUrl: String, thumbnailUrl: String, id: Int64, context: NSManagedObjectContext = moc) {
        let photo = Photo(title: title, photoURL: photoUrl, thumbnailURL: thumbnailUrl, id: id)
        savePhotos.append(photo)
        saveToPersisitentStore()
    }
    
    func deletePhotos(photo: Photo) {
        moc.delete(photo)
        saveToPersisitentStore()
    }
    
    func saveToPersisitentStore(){
        do{
            try moc.save()
        }catch{
            NSLog("Error trying to save: \(error)")
            moc.reset()
            return
        }
    }
    
}
