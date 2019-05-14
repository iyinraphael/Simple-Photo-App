//
//  PhotoViewController.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    let reuseIdentifier = "photoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let photCell = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionVIew.register(photCell, forCellWithReuseIdentifier: reuseIdentifier)
    }
    

    @IBOutlet weak var collectionVIew: UICollectionView!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
