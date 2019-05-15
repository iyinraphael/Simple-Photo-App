//
//  Simple_Photo_AppTests.swift
//  Simple-Photo-AppTests
//
//  Created by Iyin Raphael on 5/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import XCTest
@testable import Simple_Photo_App

class Simple_Photo_AppTests: XCTestCase {
    
    /**
     What we'll be testing
     - Does fetchPhotp decode when giving the right JSON
     - Are thumbnail and url valid url
     -  Is the completion handler called if the data is bad
     **/

    func testFetchData() {
        
        let mock = MockDataLoader()
        
        mock.fetchPhoto(validPhotoJSON) { (photos, error) in
            XCTAssertNil(error)
            XCTAssertEqual(photos?[1].id, 1)
            XCTAssertEqual(photos?[1].title, "accusamus beatae ad facilis cum similique qui sunt")
            XCTAssertEqual(photos?[1].thumbnailUrl, "https://via.placeholder.com/150/92c952")
            XCTAssertEqual(photos?[1].url, "https://via.placeholder.com/150/92c952")
            XCTAssertEqual(photos?.count, 14)
            
        }
    }
    
    func testUrlString() {
        
        let mock = MockDataLoader()
        
        mock.fetchPhoto(validPhotoJSON) { (photos, error) in
            
            guard let photos = photos else {return}
            
            XCTAssertNil(error)
        
            for photo in photos {
                var arrayPhoto = photo.thumbnailUrl.split(separator: ":")
                let https = arrayPhoto.removeFirst()
                XCTAssertEqual(https, "https")
            }
        }
        
    }
    
    
    func testBadData() {
        let mock = MockDataLoader()
        
        mock.fetchPhoto(invalidJSON) { (photos, error) in
            
            XCTAssertNotNil(error)
            XCTAssertNil(photos)
            
        }
    }

}
