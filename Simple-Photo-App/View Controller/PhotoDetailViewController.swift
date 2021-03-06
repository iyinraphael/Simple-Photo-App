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
    var color: UIColor?
    
    @IBOutlet weak var doneBarButtton: UIBarButtonItem!
    
    @IBOutlet weak var navBar: UINavigationBar!
    var photo: PhotoRepresentation? {
        didSet {
            createCustomImageView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBarColor()
        setUpAppearance()
        createCustomImageView()
        createTextView()
    }
    
    //MARK: - CoreData for further Implementation to save Photos to album
    @IBAction func SavePhoto(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - Creating custom imageView contrainst
    private func createCustomImageView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        let imageView = UIImageView(frame: CGRect(x: 50, y: 300, width: 300, height: 300))
        imageView.clipsToBounds = true
        let radius = imageView.frame.width / 2.0
        imageView.layer.cornerRadius = radius
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        guard let imageData = stringToData(str: photo?.url) else {return}
        imageView.image = UIImage(data: imageData)
        
        view.addSubview(imageView)
    }
    
    private func createTextView() {
        
        let textView = UITextView(frame: CGRect(x: 60, y: 620, width: 300, height: 60))
        
        guard let title = photo?.title else {return}
        textView.text = title
        textView.textColor = color
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.font = .boldSystemFont(ofSize: 20)
        
        view.addSubview(textView)
    }

    private func setBarColor() {
    
        var splitString = photo?.url.split(separator: "/")
        guard let hex = splitString?.removeLast() else {return}
        let hexColor = "#\(hex)"
        let color = UIColor(hexString: hexColor)
        self.color = color
        doneBarButtton.tintColor = .black
        navBar.backgroundColor = color
        
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
