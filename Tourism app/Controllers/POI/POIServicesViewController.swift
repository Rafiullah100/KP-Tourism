//
//  POIServicesViewController.swift
//  Tourism app
//
//  Created by Rafi on 07/11/2022.
//

import UIKit
import SDWebImage
import SVProgressHUD
class POIServicesViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var locationCategory: LocationCategory?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var archeology: Archeology?
    var wishlistAttraction: WishlistAttraction?
    var wishlistDistrict: WishlistDistrict?
    var poiCategoriId: Int?
    var districtId: Int?
    var poiName: String?

    var POISubCatories: POISubCatoriesModel?
    var POIarray: [POIRow] = [POIRow]()

    var totalCount = 0
    var currentPage = 1
    var limit = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        type = .back1
        updateUI()
        fetch()
    }
    
    private func fetch() {
        var parameters = [String: Any]()
        if exploreDistrict != nil{
            parameters = ["district_id": exploreDistrict?.id ?? 0, "poi_category_id":  poiCategoriId ?? 0, "limit": limit, "page": currentPage] as [String : Any]
        }
        else if attractionDistrict != nil{
            parameters = ["attraction_id": attractionDistrict?.id ?? 0, "poi_category_id":  poiCategoriId ?? 0, "limit": limit, "page": currentPage] as [String : Any]
        }
        else if archeology != nil{
            parameters = ["attraction_id": archeology?.attractionID ?? 0, "poi_category_id":  poiCategoriId ?? 0, "limit": limit, "page": currentPage] as [String : Any]
        }
        else if archeology != nil{
            parameters = ["attraction_id": archeology?.attractionID ?? 0, "poi_category_id":  poiCategoriId ?? 0, "limit": limit, "page": currentPage] as [String : Any]
        }
        else if wishlistDistrict != nil{
            parameters = ["district_id": wishlistDistrict?.id ?? 0, "poi_category_id":  poiCategoriId ?? 0, "limit": limit, "page": currentPage] as [String : Any]
        }
        else if wishlistAttraction != nil{
            parameters = ["attraction_id": wishlistAttraction?.id ?? 0, "poi_category_id":  poiCategoriId ?? 0, "limit": limit, "page": currentPage] as [String : Any]
        }
        print(parameters)
        URLSession.shared.request(route: .fetchPoiSubCategories, method: .post, parameters: parameters, model: POISubCatoriesModel.self) { result in
            switch result {
            case .success(let poiSubCategory):
                DispatchQueue.main.async {
                    self.POISubCatories = poiSubCategory
                    self.POIarray.append(contentsOf: poiSubCategory.pois.rows)
                    print(self.POIarray.count)
                    self.totalCount = self.POISubCatories?.pois.count ?? 0
                    self.totalCount == 0 ? self.tableView.setEmptyView("No Record Found!") : self.tableView.reloadData()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func mapBtnAction(_ sender: Any) {
//        guard let POISubCatories = POISubCatories else { return  }
        Switcher.goToPOIMap(delegate: self, locationCategory: locationCategory!, exploreDistrict: exploreDistrict, attractionDistrict: attractionDistrict, poiSubCategory: POIarray, archeology: archeology, wishlistAttraction: wishlistAttraction, wishlistDistrict: wishlistDistrict)
    }
    
    func updateUI() {
        nameLabel.attributedText = Helper.shared.attributedString(text1:poiName ?? "", text2: "| Point Of Interest")
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
        }
        else if wishlistDistrict != nil{
            thumbnailTopLabel.text = wishlistDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistDistrict?.previewImage ?? "")))
        }
        else if wishlistAttraction != nil{
            thumbnailTopLabel.text = wishlistAttraction?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistAttraction?.previewImage ?? "")))
        }
    }
}

extension POIServicesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return POIarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: POIServiceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell_identifier", for: indexPath) as! POIServiceTableViewCell
        cell.poiSubCategory = POIarray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.goToPOIDetailVC(delegate: self, poiDetail: POIarray[indexPath.row], exploredistrict: exploreDistrict, attractionDistrict: attractionDistrict, archeology: archeology)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(self.totalCount)
        if POIarray.count != totalCount && indexPath.row == POIarray.count - 1  {
            currentPage = currentPage + 1
            fetch()
        }
    }
}
