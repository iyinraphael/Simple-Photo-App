//  CoreDataStack.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack{
    
    static let shared = CoreDataStack()
    
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Simple_Photo_App" as String)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error{
                print("there was an \(error)")
            }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext{
        return container.viewContext
    }
    
}
