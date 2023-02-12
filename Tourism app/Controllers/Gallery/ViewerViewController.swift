//
//  ViewerViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/7/23.
//

import UIKit
import AVFoundation
import AVKit
class ViewerCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
}

class ViewerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var galleryDetail: GalleryModel?
    var position: IndexPath?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.scrollToItem(at: position ?? IndexPath(), at: [.centeredVertically, .centeredHorizontally], animated: false)
        collectionView.reloadData()
    }
}

extension ViewerViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryDetail?.images?.rows?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! ViewerCell
        cell.imgView.sd_setImage(with: URL(string: Route.baseUrl + (galleryDetail?.images?.rows?[indexPath.row].image_url ?? "")))
        return cell
    }
}

extension ViewerViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
