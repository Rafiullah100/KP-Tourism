//
//  VideoViewController.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import UIKit

class VideoViewController: UIViewController {

    @IBOutlet var collectionView: ASCollectionView!
    var numberOfItems: Int = 1

    let collectionElementKindHeader = "Header"
    let collectionElementKindMoreLoader = "MoreLoader"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        collectionView.asDataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: collectionElementKindHeader, bundle: nil), forSupplementaryViewOfKind: collectionElementKindHeader, withReuseIdentifier: "header")
        
    }
}

extension VideoViewController: ASCollectionViewDelegate {

    func loadMoreInASCollectionView(_ asCollectionView: ASCollectionView) {
        if numberOfItems > 30 {
            collectionView.enableLoadMore = false
            return
        }
        numberOfItems += 10
        collectionView.loadingMore = false
        collectionView.reloadData()
    }
}

extension VideoViewController: ASCollectionViewDataSource {

    func numberOfItemsInASCollectionView(_ asCollectionView: ASCollectionView) -> Int {
        return numberOfItems
    }

    func collectionView(_ asCollectionView: ASCollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCell
        gridCell.imageView.image = UIImage(named: "swat2")
        return gridCell
    }

    func collectionView(_ asCollectionView: ASCollectionView, parallaxCellForItemAtIndexPath indexPath: IndexPath) -> ASCollectionViewParallaxCell {
        let parallaxCell = collectionView.dequeueReusableCell(withReuseIdentifier: "parallaxCell", for: indexPath) as! ParallaxCell
        parallaxCell.updateParallaxImage(UIImage(named: "swat2") ?? UIImage())
        return parallaxCell
    }

    func collectionView(_ asCollectionView: ASCollectionView, headerAtIndexPath indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: ASCollectionViewElement.Header, withReuseIdentifier: "header", for: indexPath)
        return header
    }
}
