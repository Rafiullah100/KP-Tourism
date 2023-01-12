//
//  POIServicesViewController.swift
//  Tourism app
//
//  Created by Rafi on 07/11/2022.
//

import UIKit
import SDWebImage
class POIServicesViewController: BaseViewController {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    var locationCategory: LocationCategory?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var poiCategoriId: Int?
    var districtId: Int?
    
    var POISubCatories: POISubCatoriesModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let parameters = ["district_id": districtId ?? 0, "poi_category_id": poiCategoriId ?? 0] as [String : Any]
        print(parameters)
        URLSession.shared.request(route: .fetchPoiSubCategories, method: .post, parameters: parameters, model: POISubCatoriesModel.self) { result in
            switch result {
            case .success(let poiSubCategory):
                DispatchQueue.main.async {
                    self.POISubCatories = poiSubCategory
                    self.POISubCatories?.pois.count == 0 ? self.tableView.setEmptyView() : self.tableView.reloadData()
                }
            case .failure(let error):
                if error == .noInternet {
                    self.tableView.noInternet()
                }
            }
        }
    }
    
    @IBAction func mapBtnAction(_ sender: Any) {
        guard let POISubCatories = POISubCatories else { return  }
        Switcher.goToPOIMap(delegate: self, locationCategory: locationCategory!, exploreDistrict: exploreDistrict, attractionDistrict: attractionDistrict, poiSubCategory: POISubCatories)
    }
    func updateUI() {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}
