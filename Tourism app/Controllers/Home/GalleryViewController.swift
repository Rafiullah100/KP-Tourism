//
//  GalleryViewController.swift
//  Tourism app
//
//  Created by Rafi on 20/10/2022.
//

import UIKit

enum MediaType: String {
    case image
    case video
    case virtual
}

class GalleryViewController: BaseViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!{
        didSet{
            imageCollectionView.dataSource = self
            imageCollectionView.delegate = self
            imageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.cellIdentifier)
        }
    }
    @IBOutlet weak var videoCollectionView: UICollectionView!{
        didSet{
            videoCollectionView.dataSource = self
            videoCollectionView.delegate = self
            videoCollectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: VideoCollectionViewCell.cellIdentifier)
        }
    }
    @IBOutlet weak var virtualCollectionView: UICollectionView!{
        didSet{
            virtualCollectionView.dataSource = self
            virtualCollectionView.delegate = self
            virtualCollectionView.register(UINib(nibName: "VirtualCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: VirtualCollectionViewCell.cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case imageCollectionView:
           return 5
        case videoCollectionView:
            return 5
        case videoCollectionView:
            return 5
        case virtualCollectionView:
            return 5
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case imageCollectionView:
            let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.cellIdentifier, for: indexPath) as! ImageCollectionViewCell
            return cell
        case videoCollectionView:
            let cell: VideoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.cellIdentifier, for: indexPath) as! VideoCollectionViewCell
            return cell
        case virtualCollectionView:
            let cell: VirtualCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: VirtualCollectionViewCell.cellIdentifier, for: indexPath) as! VirtualCollectionViewCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoGalleryDetail(delegate: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case imageCollectionView:
            return CGSize(width: 130, height: 100)
        case videoCollectionView:
            return CGSize(width: 130, height: 100)
        case virtualCollectionView:
            return CGSize(width: 130, height: 100)
        default:
            return CGSize.zero
        }
    }
}
