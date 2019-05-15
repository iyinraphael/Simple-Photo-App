//
//  PhotoRepresentation.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation


struct PhotoRepresentation: Decodable {
    
    var title: String
    var url: String
    var thumbnailUrl: String
    var id: Int64
    
}

