//
//  HomeViewController.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private weak var photosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }

    private func configureCollectionView() {
        photosCollectionView.register(UINib(nibName: "PhotosCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: PhotosCollectionViewCell.cellIdentifier)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate {
    //Write Delegate Code Here
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.cellIdentifier, for: indexPath) as! PhotosCollectionViewCell
        
        cell.configure(index: indexPath.row)
        
        return cell
    }
    
    //Write DataSource Code Here
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let spacing: CGFloat = 10 * columns // no need to handle columns = 1
        let collectionViewMargin: CGFloat = 8.0 * 2 // both sides
        let totalSpacing: CGFloat = spacing + collectionViewMargin
        let cellWidth  = (view.frame.width - totalSpacing)/columns
        let cellHeight = cellWidth // modify if needed
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
