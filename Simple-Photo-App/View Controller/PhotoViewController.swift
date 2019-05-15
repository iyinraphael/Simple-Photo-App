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

    //MARk: - Properties
    let reuseIdentifier = "ThumbnailPhotoCollectionViewCell"
    let photoController = PhotoController()
    private let cache = Cache<Int64, UIImage>()
    private var operations = [Int64 : Operation]()
    private let photoFetchQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAppearance()
        navigationController?.navigationBar.barTintColor = .gray
        collectionVIew.backgroundColor = .gray
    
        let photCell = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionVIew.register(photCell, forCellWithReuseIdentifier: reuseIdentifier)
        photoController.fetchPhoto { (_, _) in
            DispatchQueue.main.sync {
                self.collectionVIew.reloadData()
            }
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        collectionVIew.refreshControl = refreshControl
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionVIew.reloadData()
        
    }
    
    @IBAction func refresh(_ sender: Any?) {
        collectionVIew.refreshControl?.beginRefreshing()
        
        photoController.fetchPhoto { (_, _) in
            DispatchQueue.main.sync {
                self.collectionVIew.reloadData()
                self.collectionVIew.refreshControl?.endRefreshing()

            }
        }

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
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if photoController.photos.count > 0 {
            let photo = photoController.photos[indexPath.item]
            operations[photo.id]?.cancel()
        } else {
            for (_, operation) in operations {
                operation.cancel()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        var totalUsableWidth = collectionView.frame.width
        let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        totalUsableWidth -= inset.left + inset.right
        
        let minWidth: CGFloat = 150.0
        let numberOfItemsInOneRow = Int(totalUsableWidth / minWidth)
        totalUsableWidth -= CGFloat(numberOfItemsInOneRow - 1) * flowLayout.minimumInteritemSpacing
        let width = totalUsableWidth / CGFloat(numberOfItemsInOneRow)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "photoDetailViewController") as! PhotoDetailViewController
        let photo = photoController.photos[indexPath.item]
        detailViewController.photo = photo
        detailViewController.photoController = photoController


        self.showDetailViewController(detailViewController, sender: nil)
    }
}


