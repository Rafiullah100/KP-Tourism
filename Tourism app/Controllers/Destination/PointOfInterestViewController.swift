//
//  InterestPointViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import SDWebImage
import SVProgressHUD
class PointOfInterestViewController: BaseViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "InterestPointCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: InterestPointCollectionViewCell.cellReuseIdentifier())
        }
    }
    var locationCategory: LocationCategory?
    var category: PoiCategoriesModel?
    var exploreDistrict: ExploreDistrict?
    var attractionsDistrict: AttractionsDistrict?
    var archeology: Archeology?
    var wishlistAttraction: WishlistAttraction?
    var wishlistDistrict: WishlistDistrict?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        updateUI()
    }
    
    func updateUI() {        
        if exploreDistrict != nil{
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": exploreDistrict?.id ?? 0])
        }
        else if attractionsDistrict != nil{
            thumbnailTopLabel.text = attractionsDistrict?.title
            thumbnailBottomLabel.text = attractionsDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionsDistrict?.previewImage ?? "")))
            fetch(parameters: ["attraction_id": attractionsDistrict?.id ?? 0])
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnailBottomLabel.text = archeology?.attractions.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
            fetch(parameters: ["attraction_id": archeology?.attractionID ?? 0])
        }
        else if wishlistAttraction != nil{
            thumbnailTopLabel.text = wishlistAttraction?.title
            thumbnailBottomLabel.text = wishlistAttraction?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistAttraction?.displayImage ?? "")))
            fetch(parameters: ["attraction_id": wishlistAttraction?.id ?? 0])
        }
        else if wishlistDistrict != nil{
            thumbnailTopLabel.text = wishlistDistrict?.title
            thumbnailBottomLabel.text = wishlistDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": wishlistDistrict?.id ?? 0])
        }
    }
    
    private func fetch(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchPoiCategories, method: .post, parameters: parameters, model: PoiCategoriesModel.self) { result in
            switch result {
            case .success(let poiCategory):
                self.category = poiCategory
                self.category?.poicategories.count == 0 ? self.collectionView.setEmptyView("No POI Found!") : self.collectionView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        add(vc)
    }
}

extension PointOfInterestViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.poicategories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: InterestPointCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestPointCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! InterestPointCollectionViewCell
        cell.poiCategory = category?.poicategories[indexPath.row]
        return cell
    }
}

extension PointOfInterestViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let poiCategoryId = category?.poicategories[indexPath.row].id, let poiName: String =  category?.poicategories[indexPath.row].title  else { return }
        Switcher.goToPOIServices(delegate: self, locationCategory: locationCategory!, exploredistrict: exploreDistrict, attractionDistrict: attractionsDistrict, archeology: archeology, wishlistAttraction: wishlistAttraction, wishlistDistrict: wishlistDistrict, poiCategoryId: poiCategoryId, poiName: poiName)
//        if exploreDistrict != nil{
//            guard let poiCategoryId = category?.poicategories[indexPath.row].id, let poiName: String =  category?.poicategories[indexPath.row].title  else { return }
//            Switcher.goToPOIServices(delegate: self, locationCategory: locationCategory!, exploredistrict: exploreDistrict, attractionDistrict: attractionsDistrict, poiCategoryId: poiCategoryId, poiName: poiName)
//        }
//        else if attractionsDistrict != nil{
//            guard let poiCategoryId = category?.poicategories[indexPath.row].id, let poiName: String =  category?.poicategories[indexPath.row].title else { return }
//            Switcher.goToPOIServices(delegate: self, locationCategory: locationCategory!, exploredistrict: exploreDistrict, attractionDistrict: attractionsDistrict, poiCategoryId: poiCategoryId, poiName: poiName)
//        }
//        else if archeology != nil{
//            guard let poiCategoryId = category?.poicategories[indexPath.row].id, let poiName: String =  category?.poicategories[indexPath.row].title else { return }
//            Switcher.goToPOIServices(delegate: self, locationCategory: locationCategory!, exploredistrict: exploreDistrict, attractionDistrict: attractionsDistrict, archeology: archeology, poiCategoryId: poiCategoryId, poiName: poiName)
//        }
        
    }
}

extension PointOfInterestViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 10, cellsAcross: 3)
    }
}
