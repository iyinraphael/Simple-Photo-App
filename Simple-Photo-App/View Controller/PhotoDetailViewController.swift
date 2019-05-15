//
//  PhotoDetailViewController.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photoController: PhotoController?
    var photo: Photo? {
        didSet {
            createCustomImageView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        createCustomImageView()
        createLabel()
    }
    
    //Creating custom imageView contrainst
    private func createCustomImageView() {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 150, height: 150))
        imageView.clipsToBounds = true
        let radius = imageView.frame.width / 0.5
        imageView.layer.cornerRadius = radius
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        guard let imageData = stringToData(str: photo?.photoURL) else {return}
        imageView.image = UIImage(data: imageData)
        
        view.addSubview(imageView)
    }
    
    private func createLabel() {
        let titleLabel = UILabel(frame: CGRect(x: 170, y: 170, width: 100, height: 20))
        view.addSubview(titleLabel)
    }

    
    
    
    private func stringToData(str: String?) -> Data? {
        var newData:Data?
        do{
            if let str = str {
                guard let url = URL(string: str) else {return nil}
                let data  = try Data(contentsOf: url)
                newData = data}
        } catch {
            NSLog("\(error)")
        }
        return newData
    }
    
}
