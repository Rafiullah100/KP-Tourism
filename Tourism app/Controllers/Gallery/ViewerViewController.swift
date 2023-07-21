//
//  ViewerViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/7/23.
//

import UIKit
import AVFoundation
import AVKit
import SwiftGifOrigin
import SDWebImage
import SVProgressHUD
class ViewerCell: UICollectionViewCell, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    
    var value: Int?{
        didSet{
//           scrollView.minimumZoomScale = 1.0
//           scrollView.maximumZoomScale = 5.0
//           scrollView.delegate = self
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
    var position: Int?
    var imageUrl: String?
    var galleryType: galleryType?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            guard let position = self.position else { return }
            self.collectionView.scrollToItem(at: IndexPath(row: position, section: 0), at: [.left], animated: false)
        }
    }
}

extension ViewerViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch galleryType {
        case .gallery:
            return galleryDetail?.images?.rows?.count ?? 0
        case .poi:
            return poiGallery?.count ?? 0
        case .image:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! ViewerCell
        
        switch galleryType {
        case .gallery:
            cell.value = indexPath.row
//            cell.imgView.loadGif(name: "image_loader")
            let url = URL(string: Route.baseUrl + (galleryDetail?.images?.rows?[indexPath.row].image_url ?? ""))
            cell.imgView.sd_setImage(with: url)
            SVProgressHUD.show()
            SDWebImageManager.shared.loadImage(
                with: url,
                options: .retryFailed,
                progress: nil,
                completed: { [weak image = cell.imgView.image] (image, _, error, _, _, _) in
                    SVProgressHUD.dismiss()
                    if error != nil {
                        cell.imgView.image = UIImage(named: "placeholder")
                    } else {
                        // Image loaded successfully
                        cell.imgView.image = image
                    }
                })
            
        case .poi:
            cell.value = indexPath.row
            cell.imgView.sd_setImage(with: URL(string: Route.baseUrl + (poiGallery?[indexPath.row].imageURL ?? "")))
        case .image:
            cell.imgView.sd_setImage(with: URL(string: Route.baseUrl + (imageUrl ?? "")))
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


