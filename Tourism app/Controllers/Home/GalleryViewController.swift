//
//  GalleryViewController.swift
//  Tourism app
//
//  Created by Rafi on 20/10/2022.
//

import UIKit
import SDWebImage
import SVProgressHUD
class GalleryViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
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
    
    var gallery: GalleryModel?
    var mediaType: MediaType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        fetch(route: .fetchGallery, method: .post, model: GalleryModel.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let gallery):
                self.gallery = gallery as? GalleryModel
                self.nameLabel.text = self.gallery?.attraction?.title
                self.imageView.sd_setImage(with: URL(string: Route.baseUrl + (self.gallery?.attraction?.display_image ?? "")))
                self.imageCollectionView.reloadData()
                self.videoCollectionView.reloadData()
                self.virtualCollectionView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case imageCollectionView:
            return self.gallery?.images?.count ?? 0
        case videoCollectionView:
            return self.gallery?.videos?.count ?? 0
        case virtualCollectionView:
            return self.gallery?.virtual_tours?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case imageCollectionView:
            let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.cellIdentifier, for: indexPath) as! ImageCollectionViewCell
            cell.images = gallery?.images?.rows?[indexPath.row]
            return cell
        case videoCollectionView:
            let cell: VideoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.cellIdentifier, for: indexPath) as! VideoCollectionViewCell
            cell.images = gallery?.videos?.rows?[indexPath.row]
            return cell
        case virtualCollectionView:
            let cell: VirtualCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: VirtualCollectionViewCell.cellIdentifier, for: indexPath) as! VirtualCollectionViewCell
            cell.images = gallery?.virtual_tours?.rows?[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case imageCollectionView:
            mediaType = .image
        case videoCollectionView:
            mediaType = .video
        case virtualCollectionView:
            mediaType = .virtual
        default:
            break
        }
        guard let gallery = gallery, let mediaType = mediaType else { return }
        Switcher.gotoGalleryDetail(delegate: self, galleryDetail: gallery, mediaType: mediaType)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 100)
    }
}
