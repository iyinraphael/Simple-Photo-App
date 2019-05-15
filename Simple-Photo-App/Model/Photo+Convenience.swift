//  Photo+Convenience.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation
import CoreData

extension Photo {
    
    convenience init(title:String, photoURL:String, thumbnailURL:String, id:Int64, context:NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.title = title
        self.photoURL = photoURL
        self.thumbnailURL = thumbnailURL
        self.id = id
    }
    
    convenience init?(photoRepresenation: PhotoRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        let title = photoRepresenation.title
        let photoURL = photoRepresenation.url
        let thumbnailURL = photoRepresenation.thumbnailUrl
        let id = photoRepresenation.id
        
        self.init(title:title, photoURL:photoURL, thumbnailURL: thumbnailURL, id:id, context:context)
    }
}
