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
    var poiCategoriId: Int?
    var districtId: Int?
    var poiName: String?

    var POISubCatories: POISubCatoriesModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 140.0
        tableView.rowHeight = UITableView.automaticDimension
        type = .back1
        updateUI()
        fetch()
    }
    
    private func fetch() {
        if exploreDistrict != nil{
            districtId = exploreDistrict?.id
        }
        else if attractionDistrict != nil{
            districtId = attractionDistrict?.id
        }
        let parameters = ["district_id": districtId ?? 0, "poi_category_id":  poiCategoriId ?? 0] as [String : Any]
        print(parameters)
        URLSession.shared.request(route: .fetchPoiSubCategories, method: .post, parameters: parameters, model: POISubCatoriesModel.self) { result in
            switch result {
            case .success(let poiSubCategory):
                DispatchQueue.main.async {
                    self.POISubCatories = poiSubCategory
                    self.POISubCatories?.pois.count == 0 ? self.tableView.setEmptyView("No Record Found!") : self.tableView.reloadData()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func mapBtnAction(_ sender: Any) {
        guard let POISubCatories = POISubCatories else { return  }
        Switcher.goToPOIMap(delegate: self, locationCategory: locationCategory!, exploreDistrict: exploreDistrict, attractionDistrict: attractionDistrict, poiSubCategory: POISubCatories)
    }
    
    func updateUI() {
        nameLabel.text = (poiName ?? "") + " | Point Of Interest"
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
        }
    }
}


extension POIServicesViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return POISubCatories?.pois.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: POIServiceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell_identifier", for: indexPath) as! POIServiceTableViewCell
        cell.poiSubCategory = POISubCatories?.pois.rows[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let poiDetail = POISubCatories?.pois.rows[indexPath.row] else { return }
        Switcher.goToPOIDetailVC(delegate: self, poiDetail: poiDetail)
    }
}
