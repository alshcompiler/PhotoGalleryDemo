//
//  HomeViewController.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var photosCollectionView: UICollectionView!
    
    var presenter: HomePresenter!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        configureCollectionView()
    }
    
    // MARK: - Helper Methods

    private func configureCollectionView() {
        photosCollectionView.register(UINib(nibName: "PhotosCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: PhotosCollectionViewCell.cellIdentifier)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }

    private func setupPresenter() {
        presenter = HomePresenter(view: self)
        presenter.getPhotos()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: DetailsViewController.storyboardID) as! DetailsViewController
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotosCollectionViewCell else {return}
        guard let photo = cell.photoImageView.image else {return}
        viewController.photo = photo
        // Alternative way to present the new view controller
        present(viewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter.goNextPage(index: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.cellIdentifier, for: indexPath) as! PhotosCollectionViewCell
        let photo = presenter.photos[indexPath.row]
        cell.configure(photo)
        
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

extension HomeViewController: HomeView {
    func reloadData() {
        photosCollectionView.reloadData()
    }
}
