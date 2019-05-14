//
//  Networking.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

let baseURL = URL(string: "https://jsonplaceholder.typicode.com/photos")!
extension PhotoController {
    
    func fetchPhoto(completion: @escaping completionHandler = {_, _ in }) {
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Could not fetch data from server \(error)")
            }
            guard let data = data else {
                NSLog("No data from data task")
                completion(nil, error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let photosRep = try jsonDecoder.decode([PhotoRepresentation].self, from: data).map({$0})
                let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
                backgroundContext.performAndWait {
                    for photoR in photosRep {
                        
                        _ = Photo(photoRepresenation: photoR, context: backgroundContext)
                        
                        let photo = self.fetchSinglePhotoFromPersistenceStore(id:photoR.id , context: backgroundContext)
                        
                        if let photo = photo  {
                            self.photos.append(photo)
                        }
                    self.saveToPersisitentStore(context: backgroundContext)
                        
                    }
                }
                completion(photosRep, nil)
            } catch {
                NSLog("Error decoding JSON data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
        
    }
    
}

