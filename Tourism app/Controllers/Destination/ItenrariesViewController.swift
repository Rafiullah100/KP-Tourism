//
//  ItenrariesViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit
import SVProgressHUD
class ItenrariesViewController: BaseViewController {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ItenrariesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ItenrariesCollectionViewCell.cellIdentifier)
        }
    }
    var locationCategory: LocationCategory?
    var ItinraryDetail: ItinraryModel?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var archeology: Archeology?
    var wishlistAttraction: WishlistAttraction?
    var wishlistDistrict: WishlistDistrict?

    var totalCount = 0
    var currentPage = 1
    var limit = 5
    
    var itinraryArray: [ItinraryRow] = [ItinraryRow]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let modelObject = DataManager.shared.itinraryModelObject,
           let index = itinraryArray.firstIndex(where: { $0.id == modelObject.id }) {
            itinraryArray[index] = modelObject
            collectionView.reloadData()
        }
    }
    
    private func loadData(){
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": exploreDistrict?.id ?? 0, "user_id": UserDefaults.standard.userID ?? 0, "limit": limit, "page": currentPage])
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnailBottomLabel.text = attractionDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": attractionDistrict?.districtID ?? 0, "user_id": UserDefaults.standard.userID ?? 0, "limit": limit, "page": currentPage])
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnailBottomLabel.text = archeology?.attractions.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
            fetch(parameters: ["district_id": archeology?.attractions.districtID ?? 0, "user_id": UserDefaults.standard.userID ?? 0, "limit": limit, "page": currentPage])
        }
        else if wishlistAttraction != nil{
            thumbnailTopLabel.text = wishlistAttraction?.title
            thumbnailBottomLabel.text = wishlistAttraction?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistAttraction?.displayImage ?? "")))
            fetch(parameters: ["district_id": wishlistAttraction?.districtID ?? 0, "user_id": UserDefaults.standard.userID ?? 0, "limit": limit, "page": currentPage])
        }
        if wishlistDistrict != nil {
            thumbnailTopLabel.text = wishlistDistrict?.title
            thumbnailBottomLabel.text = wishlistDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": wishlistDistrict?.id ?? 0, "user_id": UserDefaults.standard.userID ?? 0, "limit": limit, "page": currentPage])
        }
    }
    
    func fetch(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchItinraries, method: .post, parameters: parameters, model: ItinraryModel.self) { result in
            switch result {
            case .success(let itinraryDetail):
                self.itinraryArray.append(contentsOf: itinraryDetail.itineraries?.rows ?? [])
                self.totalCount = itinraryDetail.itineraries?.count ?? 0
                self.totalCount == 0 ? self.collectionView.setEmptyView("No Record found!") : self.collectionView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

extension ItenrariesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itinraryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItenrariesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItenrariesCollectionViewCell.cellIdentifier, for: indexPath) as! ItenrariesCollectionViewCell
        cell.itinrary = itinraryArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let ItinraryDetail = ItinraryDetail?.itineraries?.rows[indexPath.row] else { return }
        Switcher.goToItinraryDetail(delegate: self, itinraryDetail: itinraryArray[indexPath.row])
    }
   
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(itinraryArray.count, totalCount)
        if itinraryArray.count != totalCount && indexPath.row == itinraryArray.count - 1  {
            currentPage = currentPage + 1
            loadData()
        }
    }
}

extension ItenrariesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 5, cellsAcross: 2)
    }
}


