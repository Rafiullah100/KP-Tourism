//
//  ViewerViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/7/23.
//

import UIKit
import AVFoundation
import AVKit
class ViewerCell: UICollectionViewCell, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    
    var value: Int?{
        didSet{
           scrollView.minimumZoomScale = 1.0
           scrollView.maximumZoomScale = 5.0
           scrollView.delegate = self
        }
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imgView
    }
}

class ViewerViewController: UIViewController, UIScrollViewDelegate {

   
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var galleryDetail: GalleryModel?
    var poiGallery: [PoiGallery]?
    var position: IndexPath?
    
    var galleryType: galleryType?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.scrollToItem(at: position ?? IndexPath(), at: [.left], animated: false)
        collectionView.reloadData()
    }

}

extension ViewerViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch galleryType {
        case .gallery:
            return galleryDetail?.images?.rows?.count ?? 0
        case .poi:
            return poiGallery?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! ViewerCell
        
        switch galleryType {
        case .gallery:
            cell.value = indexPath.row
            cell.imgView.sd_setImage(with: URL(string: Route.baseUrl + (galleryDetail?.images?.rows?[indexPath.row].image_url ?? "")))
        case .poi:
            cell.value = indexPath.row
            cell.imgView.sd_setImage(with: URL(string: Route.baseUrl + (poiGallery?[indexPath.row].imageURL ?? "")))
        default:
            return cell
        }
        return cell
    }
}

extension ViewerViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
