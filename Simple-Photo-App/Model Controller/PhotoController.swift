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
    
    var photos = Array<Photo>()
    typealias completionHandler = ([PhotoRepresentation]?,Error?) -> Void
    
    func fetchSinglePhotoFromPersistenceStore(id: Int64, context: NSManagedObjectContext) -> Photo? {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as Int64)
        var photo: Photo?
        
        context.performAndWait {
            do {
                photo = try context.fetch(fetchRequest).first
            } catch {
                NSLog("Error fetching from persistent store: \(error)")
            }
        }
        return photo
    }
    
    func saveToPersisitentStore(context: NSManagedObjectContext = moc ){
        do{
            try context.save()
        }catch{
            NSLog("Error trying to save: \(error)")
            moc.reset()
            return
        }
    }
    
}
