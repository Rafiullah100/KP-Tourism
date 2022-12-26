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
    var district: ExploreDistrict?
    var poiCategoriId: Int?
    var POISubCatories: POISubCatoriesModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        updateUI()
        fetch()
    }
    
    private func fetch() {
        guard let districtId = district?.districtCategoryID, let categoryId = poiCategoriId else { return }
        let parameters = ["district_id": districtId, "poi_category_id": categoryId]
        URLSession.shared.request(route: .fetchPoiSubCategories, method: .post, parameters: parameters, model: POISubCatoriesModel.self) { result in
            switch result {
            case .success(let poiSubCategory):
                DispatchQueue.main.async {
                    self.POISubCatories = poiSubCategory
                    self.POISubCatories?.pois.count == 0 ? self.tableView.setEmptyView(title: "No Data", message: "", image: nil) : self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func mapBtnAction(_ sender: Any) {
        Switcher.goToPOIMap(delegate: self, locationCategory: locationCategory!)
    }
    func updateUI() {
        switch locationCategory {
        case .district:
            thumbnailTopLabel.text = "Swat"
            thumbnailBottomLabel.text = "KP"
            thumbnail.image = UIImage(named: "Path 94")
        case .tourismSpot:
            thumbnailTopLabel.text = "Kalam"
            thumbnailBottomLabel.text = "Swat"
            thumbnail.image = UIImage(named: "iten")
        default:
            break
        }
        thumbnailTopLabel.text = district?.title
        thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (district?.thumbnailImage ?? "")))
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
