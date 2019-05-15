//
//  MockDataLoader.swift
//  Simple-Photo-AppTests
//
//  Created by Iyin Raphael on 5/15/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

class MockDataLoader {
    
    var photos = Array<PhotoRepresentation>()
    typealias completionHandler = ([PhotoRepresentation]?,Error?) -> Void
    
    func fetchPhoto(_ data: Data, completion: @escaping completionHandler = {_, _ in }) {
            do {
                let jsonDecoder = JSONDecoder()
                let photosRep = try jsonDecoder.decode([PhotoRepresentation].self, from: data)
                self.photos = photosRep
            }
            catch {
                NSLog("Error decoding JSON data: \(error)")
                return
            }
    }
    
    
}
