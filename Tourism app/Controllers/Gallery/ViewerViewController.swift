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
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }

    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(row: position ?? 0, section: 0), at: [.top], animated: false)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let screenHeight = UIScreen.main.bounds.height
        
        switch gesture.state {
        case .changed:
            // Move the view vertically based on the gesture translation
//            view.transform = CGAffineTransform(translationX: 0, y: max(translation.y, 0))
            print("m")
        case .ended:
            // Dismiss the view controller if dragged beyond a certain threshold or animate it back to its original position
            let velocity = gesture.velocity(in: view)
            let dismissThreshold: CGFloat = screenHeight * 0.1
            if translation.y > dismissThreshold || velocity.y > 200 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = .identity
                }
            }
            
        default:
            break
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
            SDWebImageManager.shared.loadImage(
                with: url,
                options: .retryFailed,
                progress: nil,
                completed: { [weak image = cell.imgView.image] (image, _, error, _, _, _) in
                    if error != nil {
                        cell.imgView.loadGif(name: "image_loader")
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


