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
    private let cache = Cache<Int64, UIImage>()
    private var operations = [Int64 : Operation]()
    private let photoFetchQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let photCell = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionVIew.register(photCell, forCellWithReuseIdentifier: reuseIdentifier)
        collectionVIew.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         collectionVIew.reloadData()
    }
    

    @IBOutlet weak var collectionVIew: UICollectionView!
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    //MARK: - Cache and Concurrency(NSOperation)
    private func loadImage(forCell cell: ThumbnailPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoController.photos[indexPath.item]
        if let cachedImage = cache.value(for: photo.id as Int64) {
            cell.imageView.image = cachedImage
            return
        }
        let fetchOp = FetchPhotoOperation(photo: photo)
        let cacheOp = BlockOperation {
            if let image = fetchOp.image {
                self.cache.cache(value: image, for: photo.id)
            }
        }
        let completionOp = BlockOperation {
            defer {self.operations.removeValue(forKey:photo.id)}
            
            if let currentIndexpath = self.collectionVIew.indexPath(for: cell),
                currentIndexpath != indexPath {
                return
            }
            if let image = fetchOp.image {
                cell.imageView.image = image
            }
        }
        cacheOp.addDependency(fetchOp)
        completionOp.addDependency(fetchOp)
        
        photoFetchQueue.addOperation(fetchOp)
        photoFetchQueue.addOperation(cacheOp)
        OperationQueue.main.addOperation(completionOp)
        
        operations[photo.id] = fetchOp
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

    // MARK: - UICollection Delagate and Data Source
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoController.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ThumbnailPhotoCollectionViewCell else {return UICollectionViewCell()}
        
        loadImage(forCell: cell, forItemAt: indexPath)
        
        return cell
    }
}


