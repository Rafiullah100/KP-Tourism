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
import SVProgressHUD

class GalleryDetailViewController: BaseViewController {
    @IBOutlet weak var noDataLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabbarView: MDCTabBarView!
    
    @IBOutlet weak var collectionView: ASCollectionView!
    
    var numberOfItems: Int = 10
    let collectionElementKindHeader = "Header"
    let collectionElementKindMoreLoader = "MoreLoader"
    
    var galleryDetail: GalleryModel?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var archeology: Archeology?
    

    var mediaType: MediaType?
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    var tabbarItems = [UITabBarItem]()

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
                fetch(route: .galleryByDistrict, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0], model: GalleryModel.self)
            }
            else if attractionDistrict != nil{
                fetch(route: .galleryByDistrict, method: .post, parameters: ["attraction_id": attractionDistrict?.id ?? 0], model: GalleryModel.self)
            }
            else if archeology != nil{
                fetch(route: .galleryByDistrict, method: .post, parameters: ["attraction_id": archeology?.attractions.id ?? 0], model: GalleryModel.self)
            }
            else{
                fetch(route: .fetchGallery, method: .post, parameters: ["district_id": archeology?.attractions.id ?? 0], model: GalleryModel.self)
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        dataTask = URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let galleryDetail):
                self.galleryDetail = galleryDetail as? GalleryModel
                if self.galleryDetail?.images?.count == 0 {
                    self.noDataLabel.text = "No image found!"
                }
                else{
                    self.noDataLabel.text = ""
                }
                self.collectionView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    private func configureTab(){
        var tag = 0
        for item in Constants.gallerySection {
            let tabbarItem = UITabBarItem(title: item.title, image: UIImage(named: item.image), tag: tag)
            tag = tag + 1
            tabbarItems.append(tabbarItem)
        }
        tabbarView.items = tabbarItems
        tabbarView.tabBarDelegate = self
        tabbarView.delegate = self
        Helper.shared.customTab(tabbar: tabbarView, items: tabbarItems)
        switch mediaType {
        case .image:
            tabbarView.selectedItem = tabbarView.items[0]
        case .video:
            tabbarView.selectedItem = tabbarView.items[1]
        case .virtual:
            tabbarView.selectedItem = tabbarView.items[2]
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tabbarView {
            Helper.shared.disableVerticalScrolling(tabbarView)
        }
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
            if self.galleryDetail?.images?.count == 0{
                collectionView.setEmptyView("")
                noDataLabel.text = "No image found!"
            }
            else{
                self.noDataLabel.text = ""
            }
        case 1:
            mediaType = .video
            if self.galleryDetail?.videos?.count == 0{
                collectionView.setEmptyView("")
                noDataLabel.text = "No video found!"
            }
            else{
                self.noDataLabel.text = ""
            }
        case 2:
            mediaType = .virtual
            if self.galleryDetail?.virtual_tours?.count == 0{
                collectionView.setEmptyView("")
                noDataLabel.text = "No virtual tour found!"
            }
            else{
                self.noDataLabel.text = ""
            }
        default:
            mediaType = .image
        }
        collectionView.reloadData()
    }
}

extension GalleryDetailViewController: ASCollectionViewDelegate, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mediaType {
        case .image:
            Switcher.gotoViewerVC(delegate: self, galleryDetail: galleryDetail!, position: indexPath.row, type: .gallery)
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
            gridCell.imageView.sd_setImage(with: URL(string: Route.baseUrl + (galleryDetail?.images?.rows?[indexPath.row].image_url ?? "")), placeholderImage: UIImage(named: "thumbnail.jpg"))
        case .video:
            gridCell.imageView.image = UIImage(named: "thumbnail.jpg")
        case .virtual:
            gridCell.imageView.image = UIImage(named: "thumbnail.jpg")
        default:
            return gridCell
        }
        return gridCell
    }

    func collectionView(_ asCollectionView: ASCollectionView, parallaxCellForItemAtIndexPath indexPath: IndexPath) -> ASCollectionViewParallaxCell {
        let parallaxCell = collectionView.dequeueReusableCell(withReuseIdentifier: "parallaxCell", for: indexPath) as! ParallaxCell
        switch mediaType {
        case .image:
            parallaxCell.parallaxImageView.sd_setImage(with: URL(string: Route.baseUrl + (galleryDetail?.images?.rows?[indexPath.row].image_url ?? "")), placeholderImage: UIImage(named: "thumbnail.jpg"))
        case .video:
            parallaxCell.parallaxImageView.image = UIImage(named: "thumbnail.jpg")
        case .virtual:
            parallaxCell.parallaxImageView.image = UIImage(named: "thumbnail.jpg")
        default:
            return parallaxCell
        }
        return parallaxCell
    }
    
    func collectionView(_ asCollectionView: ASCollectionView, headerAtIndexPath indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: ASCollectionViewElement.Header, withReuseIdentifier: "header", for: indexPath)
        return header
    }
}
    
    class GridCell: UICollectionViewCell {

        @IBOutlet var imageView: UIImageView!
    }

    class ParallaxCell: ASCollectionViewParallaxCell {
    }
