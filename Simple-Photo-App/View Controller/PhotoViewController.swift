//
//  PhotoViewController.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit
import CoreData

class PhotoViewController: UIViewController {

    let reuseIdentifier = "ThumbnailPhotoCollectionViewCell"
    let photoController = PhotoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let photCell = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionVIew.register(photCell, forCellWithReuseIdentifier: reuseIdentifier)
    }
    

    @IBOutlet weak var collectionVIew: UICollectionView!
    
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }

}

// MARK: - UICollection Delagate and Data Source
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ThumbnailPhotoCollectionViewCell else {return UICollectionViewCell()}
        return cell
    }
}


// MARk: - NSFetchControllerDelegate
extension PhotoController: NSFetchedResultsControllerDelegate {
    
    
    
}
