//
//  TourDestinationViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/30/23.
//

import UIKit
import SDWebImage
class TourAccomodatioCell: UITableViewCell {
    //
    @IBOutlet weak var selectedImgView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imageBGView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var list: DistrictsListRow? {
        didSet {
            label.text = list?.title
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (list?.preview_image ?? "")))
            
            bottomView.clipsToBounds = true
            bottomView.layer.cornerRadius = 10
            bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

            imageBGView.clipsToBounds = true
            imageBGView.layer.cornerRadius = 10
            imageBGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomView.viewShadow()
        }
    }
    
    var experienceID: Int?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedImgView.isHidden = selected ? false : true
    }
}

class TourDestinationViewController: BaseViewController {
    
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var districtList: [DistrictsListRow]?
    var isSelected: Bool?
    var geoTypeId: String?
    var experienceId: Int?
    var districtID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .visitKP
        viewControllerTitle = "Tour Planner"
        fetchList(parameters: ["limit": 50, "district_category_id": experienceId ?? 0, "geoType": geoTypeId ?? ""])
    }
    
    func fetchList(parameters: [String: Any]) {
        URLSession.shared.request(route: .districtListApi, method: .post, parameters: parameters, model: DistrictListModel.self) { result in
            switch result {
            case .success(let DistrictListM):
                DispatchQueue.main.async {
                    self.districtList = DistrictListM.districts?.rows
                    self.districtList?.count == 0 ? self.tableView.setEmptyView() : self.tableView.reloadData()
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func forwardBtnAction(_ sender: Any) {
        if isSelected == true{
            Switcher.gotoTourInformationVC(delegate: self, districtID: districtID ?? 0)
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension TourDestinationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return districtList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TourAccomodatioCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! TourAccomodatioCell
        cell.list = districtList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Switcher.gotoTourInformationVC(delegate: self)
        districtID = districtList?[indexPath.row].id
        isSelected = true
        UserDefaults.standard.destination = districtList?[indexPath.row].title
    }
}


