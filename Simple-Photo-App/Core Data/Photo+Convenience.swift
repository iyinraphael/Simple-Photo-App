//  Photo+Convenience.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation
import CoreData

extension Photo {
    
    convenience init(title:String, photoURL:URL, thumbnailURL:URL, id:Int64, context:NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.title = title
        self.photoURL = photoURL
        self.thumbnailURL = thumbnailURL
        self.id = id
    }
    
}
