//
//  GalleryDetailViewController.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import UIKit
import MaterialComponents.MaterialTabs_TabBarView
import SDWebImage
class GalleryDetailViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabbarView: MDCTabBarView!
    
    @IBOutlet weak var collectionView: ASCollectionView!
    
    var numberOfItems: Int = 10
    let collectionElementKindHeader = "Header"
    let collectionElementKindMoreLoader = "MoreLoader"
    
    var galleryDetail: GalleryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .back1
        configureTab()
        
        navigationController?.navigationBar.isHidden = false
        collectionView.asDataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: collectionElementKindHeader, bundle: nil), forSupplementaryViewOfKind: collectionElementKindHeader, withReuseIdentifier: "header")
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
//        self.add(imageVC, in: containerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       //
    }
}

extension GalleryDetailViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        addChild(tag: item.tag)
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

extension GalleryDetailViewController: ASCollectionViewDelegate {

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
        return galleryDetail?.images?.rows?.count ?? 0
    }
    
    func collectionView(_ asCollectionView: ASCollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCell
        gridCell.imageView.sd_setImage(with: URL(string: Route.baseUrl + (galleryDetail?.images?.rows?[indexPath.row].image_url ?? "")))
        return gridCell
    }
    
    func collectionView(_ asCollectionView: ASCollectionView, parallaxCellForItemAtIndexPath indexPath: IndexPath) -> ASCollectionViewParallaxCell {
        let parallaxCell = collectionView.dequeueReusableCell(withReuseIdentifier: "parallaxCell", for: indexPath) as! ParallaxCell
        parallaxCell.parallaxImageView.sd_setImage(with: URL(string: Route.baseUrl + (galleryDetail?.images?.rows?[indexPath.row].image_url ?? "")))
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
