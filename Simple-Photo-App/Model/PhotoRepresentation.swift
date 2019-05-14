//
//  PhotoRepresentation.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation


struct PhotoRepresentation: Decodable {
    
    var title: String?
    var photoURL: URL?
    var thumbnailURL: URL?
    var id: Int64?
    
    static func == (lhs: PhotoRepresentation, rhs: Photo) -> Bool {
        return rhs.title == lhs.title &&
        rhs.photoURL == lhs.photoURL &&
        rhs.thumbnailURL == lhs.thumbnailURL &&
        rhs.id == lhs.id
    }
    
    static func == (lhs: Photo, rhs: PhotoRepresentation) -> Bool {
        return rhs == lhs
    }
    
    static func != (lhs: PhotoRepresentation, rhs: Photo) -> Bool {
        return !(lhs == rhs)
    }
    
    static func != (lhs: Photo, rhs: PhotoRepresentation) -> Bool {
        return rhs != lhs
    }
}
