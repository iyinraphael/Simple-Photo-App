//
//  PhotoDetailViewController.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCustomImageView()
    }
    
    //Creating custom imageView contrainst
    private func createCustomImageView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 150, height: 150))
        imageView.clipsToBounds = true
        
        let radius = imageView.frame.width / 0.5
        imageView.layer.cornerRadius = radius
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        
        
    }

}
