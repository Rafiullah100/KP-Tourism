//
//  AttractionViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import SVProgressHUD
class AttractionViewController: BaseViewController {
    
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

    var attractionDistrictsArray: [AttractionsDistrict] = [AttractionsDistrict]()

    var currentPage = 1
    var totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        switchBtn(travel: .textual)
        loadData(currentPage: currentPage)
    }
    
    private func loadData(currentPage: Int){
        if exploreDistrict != nil {
            sectionLabel.text = "Attractions"
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(route: .fetchAttractionByDistrict, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0, "type": "attraction", "limit": 5, "page": currentPage, "user_id": UserDefaults.standard.userID ?? 0], model: AttractionModel.self)
        }
        else if attractionDistrict != nil{
            sectionLabel.text = "What to see"
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnailBottomLabel.text = attractionDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
            fetch(route: .fetchAttractionByDistrict, method: .post, parameters: ["district_id": attractionDistrict?.id ?? 0, "attraction_id": 1, "type": "sub_attraction", "limit": 5, "page": currentPage, "user_id": UserDefaults.standard.userID ?? 0], model: AttractionModel.self)
        }
        else if archeology != nil{
            sectionLabel.text = "Attractions"
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnailBottomLabel.text = archeology?.attractions.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
            fetch(route: .fetchAttractionByDistrict, method: .post, parameters: ["district_id": archeology?.attractions.id ?? 0, "type": "attraction", "limit": 5, "page": currentPage, "user_id": UserDefaults.standard.userID ?? 0], model: AttractionModel.self)
        }
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let attractions):
                self.attractionDistrictsArray.append(contentsOf: (attractions as? AttractionModel)?.attractions?.rows ?? [])
                self.totalPages = (attractions as? AttractionModel)?.attractions?.count ?? 1
                self.attractionDistrictsArray.count == 0 ? self.collectionView.setEmptyView("No Record found!") : self.collectionView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: "\(error.localizedDescription)")
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
}

extension AttractionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attractionDistrictsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestAttractCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestAttractCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! DestAttractCollectionViewCell
        cell.actionBlock = {
            self.like(route: .likeApi, method: .post, parameters: ["section_id": self.attractionDistrictsArray[indexPath.row].id ?? 0, "section": "attraction"], model: SuccessModel.self, cell: cell)
        }
        cell.attraction = attractionDistrictsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if locationCategory == .district{
            Switcher.goToDestination(delegate: self, type: .tourismSpot, attractionDistrict: attractionDistrictsArray[indexPath.row])
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
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, cell: DestAttractCollectionViewCell) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let like):
                let successDetail = like as? SuccessModel
                DispatchQueue.main.async {
                    cell.favoriteBtn.setImage(successDetail?.message == "Liked" ? UIImage(named: "fav") : UIImage(named: "unfavorite-gray"), for: .normal)
                }
            case .failure(let error):
                print("error \(error)")
            }
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

