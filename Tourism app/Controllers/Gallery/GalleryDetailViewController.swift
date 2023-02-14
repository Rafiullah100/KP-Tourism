//
//  GalleryDetailViewController.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import UIKit
import MaterialComponents.MaterialTabs_TabBarView
import SDWebImage
import AVFoundation
import AVKit

class GalleryDetailViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabbarView: MDCTabBarView!
    
    @IBOutlet weak var collectionView: ASCollectionView!
    
    var numberOfItems: Int = 10
    let collectionElementKindHeader = "Header"
    let collectionElementKindMoreLoader = "MoreLoader"
    
    var galleryDetail: GalleryModel?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?

    var mediaType: MediaType?
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .back1
        configureTab()
        
        navigationController?.navigationBar.isHidden = false
        collectionView.asDataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: collectionElementKindHeader, bundle: nil), forSupplementaryViewOfKind: collectionElementKindHeader, withReuseIdentifier: "header")
        if galleryDetail == nil{
            if exploreDistrict != nil{
                fetch(route: .fetchGallery, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0], model: GalleryModel.self)
            }
            else if attractionDistrict != nil{
                fetch(route: .fetchGallery, method: .post, parameters: ["district_id": attractionDistrict?.id ?? 0], model: GalleryModel.self)
            }
        }
    }
    
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let galleryDetail):
                DispatchQueue.main.async {
                    self.galleryDetail = galleryDetail as? GalleryModel
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                if error == .noInternet {
                    self.collectionView.noInternet()
                }
            }
        }
    }
    
    private func configureTab(){
        tabbarView.items = [
          UITabBarItem(title: "Images", image: UIImage(named: ""), tag: 0),
          UITabBarItem(title: "Videos", image: UIImage(named: ""), tag: 1),
          UITabBarItem(title: "Virtual Tours", image: UIImage(named: ""), tag: 2),
        ]
        tabbarView.selectedItem = tabbarView.items[0]
        tabbarView.selectionIndicatorStrokeColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
        tabbarView.preferredLayoutStyle = .fixed
        tabbarView.isScrollEnabled = false
        tabbarView.setTitleFont(UIFont(name: "Roboto-Light", size: 12.0), for: .normal)
        tabbarView.setTitleFont(UIFont(name: "Roboto-Medium", size: 12.0), for: .selected)
        tabbarView.setTitleColor(.darkGray, for: .normal)
        tabbarView.setTitleColor(Constants.appColor, for: .selected)
        tabbarView.tabBarDelegate = self
        tabbarView.minItemWidth = 10
        mediaType = .image
//        self.add(imageVC, in: containerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       //
    }
    
    private func playVideo(url: String){
        let videoURL = URL(string: Route.baseUrl + url)
        guard let videoURL = videoURL else { return }
        player = AVPlayer(url: videoURL)
        playerViewController.player = player
        self.present(playerViewController, animated: true)
    }
}

extension GalleryDetailViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            mediaType = .image
        case 1:
            mediaType = .video
        case 2:
            mediaType = .virtual
        default:
            break
        }
        collectionView.reloadData()
    }
    
    private func addChild(tag: Int){
        
//        self.remove(from: containerView)
//        if tag == 0 {
//            self.add(imageVC, in: containerView)
//        }
//        else if tag == 1{
//            self.add(videoVC, in: containerView)
//        }
//        else if tag == 2{
//            self.add(tourVC, in: containerView)
//        }
    }
}

extension GalleryDetailViewController: ASCollectionViewDelegate, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mediaType {
        case .image:
            Switcher.gotoViewerVC(delegate: self, galleryDetail: galleryDetail!, position: indexPath, type: .gallery)
        case .video:
            playVideo(url: galleryDetail?.videos?.rows?[indexPath.row].video_url ?? "")
        case .virtual:
            playVideo(url: galleryDetail?.virtual_tours?.rows?[indexPath.row].virtual_url ?? "")
        default:
            break
        }
    }
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

extension GalleryDetailViewController: ASCollectionViewDataSource {
    
    func numberOfItemsInASCollectionView(_ asCollectionView: ASCollectionView) -> Int {
        switch mediaType {
        case .image:
            return galleryDetail?.images?.rows?.count ?? 0
        case .video:
            return galleryDetail?.videos?.rows?.count ?? 0
        case .virtual:
            return galleryDetail?.virtual_tours?.rows?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ asCollectionView: ASCollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCell
        switch mediaType {
        case .image:
            gridCell.imageView.sd_setImage(with: URL(string: Route.baseUrl + (galleryDetail?.images?.rows?[indexPath.row].image_url ?? "")))
        case .video:
            gridCell.imageView.image = Helper.shared.getThumbnailImage(forUrl: URL(string: Route.baseUrl + (galleryDetail?.videos?.rows?[indexPath.row].video_url ?? "")))
        case .virtual:
            gridCell.imageView.image = Helper.shared.getThumbnailImage(forUrl: URL(string: Route.baseUrl + (galleryDetail?.virtual_tours?.rows?[indexPath.row].video_url ?? "")))
        default:
            return gridCell
        }
        return gridCell
    }
    //imgView.image = Helper.shared.getThumbnailImage(forUrl: URL(string: Route.baseUrl + (images?.video_url ?? "")))
    func collectionView(_ asCollectionView: ASCollectionView, parallaxCellForItemAtIndexPath indexPath: IndexPath) -> ASCollectionViewParallaxCell {
        let parallaxCell = collectionView.dequeueReusableCell(withReuseIdentifier: "parallaxCell", for: indexPath) as! ParallaxCell
        parallaxCell.parallaxImageView.sd_setImage(with: URL(string: Route.baseUrl + (galleryDetail?.images?.rows?[indexPath.row].image_url ?? "")))
        switch mediaType {
        case .image:
            parallaxCell.parallaxImageView.sd_setImage(with: URL(string: Route.baseUrl + (galleryDetail?.images?.rows?[indexPath.row].image_url ?? "")))
        case .video:
            parallaxCell.parallaxImageView.image = Helper.shared.getThumbnailImage(forUrl: URL(string: Route.baseUrl + (galleryDetail?.videos?.rows?[indexPath.row].video_url ?? "")))
        case .virtual:
            parallaxCell.parallaxImageView.image = Helper.shared.getThumbnailImage(forUrl: URL(string: Route.baseUrl + (galleryDetail?.virtual_tours?.rows?[indexPath.row].video_url ?? "")))
        default:
            return parallaxCell
        }
        return parallaxCell
    }
    
    func collectionView(_ asCollectionView: ASCollectionView, headerAtIndexPath indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: ASCollectionViewElement.Header, withReuseIdentifier: "header", for: indexPath)
        return header
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        Switcher.gotoViewerVC(delegate: self, galleryDetail: galleryDetail!)
//    }
    
}
    
    class GridCell: UICollectionViewCell {

        @IBOutlet var imageView: UIImageView!
    }

    class ParallaxCell: ASCollectionViewParallaxCell {
    }
