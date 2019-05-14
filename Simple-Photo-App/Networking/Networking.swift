//
//  Networking.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

let baseURL = URL(string: "http://jsonplaceholder.typicode.com/photos")!
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
        
                
            } catch {
                
            }
        }
        
    }
    
}
