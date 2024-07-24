//
//  AttractionViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import SVProgressHUD
class AttractionViewController: BaseViewController {
  
    
    @IBOutlet weak var filterView: FilterView!
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var constainerView: UIView!
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "DestAttractCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DestAttractCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    
    var locationCategory: LocationCategory?
    var exploreDistrict: ExploreDistrict?
    var attractionDetail: AttractionModel?
    var attractionDistrict: AttractionsDistrict?
    var archeology: Archeology?
    var wishlistAttraction: WishlistAttraction?
    var wishlistDistrict: WishlistDistrict?

    var attractionDistrictsArray: [AttractionsDistrict] = [AttractionsDistrict]()

    var currentPage = 1
    var totalPages = 1
    var districtID: Int?
    var isFilter: String?
    
    override func filterAction() {
        filterView.delegate = self
        filterView.categories = attractionDetail?.categories
        filterView.isHidden = !filterView.isHidden
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        showfilterButton = false
        filterView.layer.cornerRadius = 10.0
        type = .back1
        switchBtn(travel: .textual)
        loadData(currentPage: currentPage)
        filterView.viewShadow()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        filterView.collectionviewHeight.constant = filterView.collectionView.contentSize.height
    }
    
    private func loadData(currentPage: Int){
        if exploreDistrict != nil {
            sectionLabel.text = "Attractions"
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": exploreDistrict?.id ?? 0, "isFilter": isFilter ?? "", "type": "attraction", "limit": 5, "page": currentPage, "user_id": UserDefaults.standard.userID ?? 0])
        }
        else if attractionDistrict != nil{
            sectionLabel.text = "What to see"
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnailBottomLabel.text = attractionDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": attractionDistrict?.districtID ?? 0, "attraction_id": attractionDistrict?.id ?? 0,  "isFilter": isFilter ?? "", "type": "sub_attraction", "limit": 5, "page": currentPage, "user_id": UserDefaults.standard.userID ?? 0])
        }
        else if archeology != nil{
            sectionLabel.text = "Attractions"
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnailBottomLabel.text = archeology?.attractions.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
            fetch(parameters: ["district_id": archeology?.attractions.districtID ?? 0, "attraction_id": archeology?.attractionID ?? 0, "isFilter": isFilter ?? "", "type": "attraction", "limit": 5, "page": currentPage, "user_id": UserDefaults.standard.userID ?? 0])
        }
        else if wishlistAttraction != nil{
            sectionLabel.text = "What to see"
            thumbnailTopLabel.text = wishlistAttraction?.title
            thumbnailBottomLabel.text = wishlistAttraction?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistAttraction?.displayImage ?? "")))
            fetch(parameters: ["district_id": wishlistAttraction?.districtID ?? 0, "attraction_id": wishlistAttraction?.id ?? 0, "isFilter": isFilter ?? "", "type": "sub_attraction", "limit": 5, "page": currentPage, "user_id": UserDefaults.standard.userID ?? 0])
           
        }
        if wishlistDistrict != nil {
            sectionLabel.text = "Attractions"
            thumbnailTopLabel.text = wishlistDistrict?.title
            thumbnailBottomLabel.text = wishlistDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": wishlistDistrict?.id ?? 0, "isFilter": isFilter ?? "", "type": "attraction", "limit": 5, "page": currentPage, "user_id": UserDefaults.standard.userID ?? 0])
            
        }
    }
    
    func fetch(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .fetchAttractionByDistrict, method: .post, parameters: parameters, model: AttractionModel.self) { result in
            switch result {
            case .success(let attractionDetail):
                self.attractionDetail = attractionDetail
                self.attractionDistrictsArray.append(contentsOf: attractionDetail.attractions?.rows ?? [])
                print(self.attractionDetail)
                self.totalPages = attractionDetail.attractions?.count ?? 1
                self.attractionDistrictsArray.count == 0 ? self.collectionView.setEmptyView("No Record found!") : self.collectionView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        let vc: AttractionMapViewController = UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "AttractionMapViewController") as! AttractionMapViewController
        vc.attractionsArray = self.attractionDistrictsArray
        add(vc, in: mapContainerView)
    }
    
    @IBAction func textualButtonAction(_ sender: Any) {
        switchBtn(travel: .textual)
    }
    
    @IBAction func mapBtnAction(_ sender: Any) {
        switchBtn(travel: .navigation)
        show(UIViewController(), sender: self)
    }
    
    private func switchBtn(travel: Travel){
        switch travel {
        case .textual:
            mapContainerView.isHidden = true
            constainerView.isHidden = false
            listImageView.image = UIImage(named: "grid-green")
            mapImageView.image = UIImage(named: "map-white")
        case .navigation:
            mapContainerView.isHidden = false
            constainerView.isHidden = true
            listImageView.image = UIImage(named: "grid-white")
            mapImageView.image = UIImage(named: "map-green")
        }
    }
    
    func toggleWishlistStatus(for indexPath: IndexPath) {
        var attraction = attractionDistrictsArray[indexPath.row]
        attraction.isWished = attraction.isWished == 1 ? 0 : 1
        attractionDistrictsArray[indexPath.row] = attraction
        collectionView.reloadItems(at: [indexPath])
    }
}

extension AttractionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attractionDistrictsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestAttractCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestAttractCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! DestAttractCollectionViewCell
        cell.likeButtonTappedHandler = {
            self.toggleWishlistStatus(for: indexPath)
        }
        cell.configure(attraction: attractionDistrictsArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if locationCategory == .district{
            Switcher.goToDestination(delegate: self, type: .tourismSpot, attractionDistrict: attractionDistrictsArray[indexPath.row], distirctID: districtID ?? 0)
        }
        else if locationCategory == .tourismSpot{
            Switcher.gotoAttractionDetail(delegate: self, attractionDistrict: attractionDistrictsArray[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if totalPages != attractionDistrictsArray.count && indexPath.row == attractionDistrictsArray.count-1  {
            currentPage = currentPage + 1
            loadData(currentPage: currentPage)
        }
    }
}

extension AttractionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width * 0.65)
    }
}

extension AttractionViewController: PopupDelegate{
    func showPopup() {
       // Switcher.gotoFilterVC(delegate: self)
    }
}


extension AttractionViewController: FilterDelegate{
    func applyFilter(ids: String) {
        totalPages = 1
        currentPage = 1
        filterView.isHidden = true
        attractionDistrictsArray = []
        isFilter = ids
//        guard !ids.isEmpty else {
//            return
//        }
        loadData(currentPage: currentPage)
    }
}
