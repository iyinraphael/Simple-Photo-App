//
//  FetchPhotoOperation.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit


class FetchPhotoOperation: ConcurrentOperation {
    
    init(photo: PhotoRepresentation, session: URLSession = URLSession.shared) {
        self.photo = photo
        self.session = session
        super.init()
    }
    
    override func start() {
        state = .isExecuting
        let photoString = photo.thumbnailUrl
        let url = URL(string: photoString)!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            defer { self.state = .isFinished }
            if self.isCancelled { return }
            if let error = error {
                NSLog("Error fetching data for \(self.photo): \(error)")
                return
            }
            
            if let data = data {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
        dataTask = task
    }
    
    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
    
    // MARK: Properties
    let photo: PhotoRepresentation
    private let session: URLSession
    private(set) var image: UIImage?
    private var dataTask: URLSessionDataTask?
}
