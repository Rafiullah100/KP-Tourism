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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        updateUI()
        fetch()
    }
    
    func updateUI() {        
        if exploreDistrict != nil{
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
        }
        else if attractionsDistrict != nil{
            thumbnailTopLabel.text = attractionsDistrict?.title
            thumbnailBottomLabel.text = attractionsDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionsDistrict?.previewImage ?? "")))
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions?.title
            thumbnailBottomLabel.text = attractionsDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.image_url ?? "")))
        }
    }
    
    private func fetch() {
        URLSession.shared.request(route: .fetchPoiCategories, method: .post, model: PoiCategoriesModel.self) { result in
            switch result {
            case .success(let poiCategory):
                self.category = poiCategory
                self.category?.poicategories.count == 0 ? self.collectionView.setEmptyView("No POI Found!") : self.collectionView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
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
        
        if exploreDistrict != nil{
            guard let poiCategoryId = category?.poicategories[indexPath.row].id, let poiName: String =  category?.poicategories[indexPath.row].title  else { return }
            Switcher.goToPOIServices(delegate: self, locationCategory: locationCategory!, exploredistrict: exploreDistrict, attractionDistrict: attractionsDistrict, poiCategoryId: poiCategoryId, poiName: poiName)
        }
        else if attractionsDistrict != nil{
            guard let poiCategoryId = category?.poicategories[indexPath.row].id, let poiName: String =  category?.poicategories[indexPath.row].title else { return }
            Switcher.goToPOIServices(delegate: self, locationCategory: locationCategory!, exploredistrict: exploreDistrict, attractionDistrict: attractionsDistrict, poiCategoryId: poiCategoryId, poiName: poiName)
        }
        else if archeology != nil{
            guard let poiCategoryId = category?.poicategories[indexPath.row].id, let poiName: String =  category?.poicategories[indexPath.row].title else { return }
            Switcher.goToPOIServices(delegate: self, locationCategory: locationCategory!, exploredistrict: exploreDistrict, attractionDistrict: attractionsDistrict, poiCategoryId: poiCategoryId, poiName: poiName)
        }
    }
}

extension PointOfInterestViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 2, cellsAcross: 4)
    }
}
