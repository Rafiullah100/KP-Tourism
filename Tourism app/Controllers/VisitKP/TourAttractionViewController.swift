//
//  ExperienceViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/30/23.
//

import UIKit
import TagListView
class VisitAttractionTableViewCell: UITableViewCell {
    //
    @IBOutlet weak var selectedImgView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imageBGView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var tagView: TagListView!
    
    var tagsArray = [String]()
    
    var attraction: TourAttractionsRow? {
        didSet {
            tagView.isUserInteractionEnabled = false
            label.text = attraction?.title
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (attraction?.previewImage ?? "")))
            
            bottomView.clipsToBounds = true
            bottomView.layer.cornerRadius = 10
            bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

            imageBGView.clipsToBounds = true
            imageBGView.layer.cornerRadius = 10
            imageBGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomView.viewShadow()
            tagsArray = []
            attraction?.attractionCategoryPivots?.forEach({ pivot in
                tagsArray.append(pivot.attractionCategories?.title ?? "")
            })
            tagView.removeAllTags()
            tagView.addTags(tagsArray)
            tagView.alignment = .center
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedImgView.isHidden = selected ? false : true
    }
}

class TourAttractionViewController: BaseViewController {

    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
   
    var attractions: [TourAttractionsRow]?
    var isSelected: Bool?
    var districtId: Int?
//    var geoTypeId: String?
    var attractionId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .visitKP
        viewControllerTitle = "Tour Planner"
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        fetch()
    }
    
    func fetch() {
        print(districtId ?? 0)
        dataTask = URLSession.shared.request(route: .tourAttraction, method: .post, parameters: ["district_id": districtId ?? 0, "limit": 5, "page": 1], model: TourAttractionModel.self) { result in
            switch result {
            case .success(let attraction):
                self.attractions = attraction.attractions?.rows
                print(self.attractions ?? [])
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func forwardBtnAction(_ sender: Any) {
        if isSelected == true{
//            Switcher.gotoTourDestinationVC(delegate: self, experienceID: experienceId ?? 0, geoTypeID: geoTypeId ?? "")
            Switcher.gotoTourInformationVC(delegate: self, districtID: districtId ?? 0)
        }
        else{
            self.view.makeToast("Please select what would you like to experience")
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension TourAttractionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractions?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VisitAttractionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! VisitAttractionTableViewCell
        cell.attraction = attractions?[indexPath.row]
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        attractionId = attractions?[indexPath.row].id
        isSelected = true
        guard let attraction = attractions?[indexPath.row] else { return }
        UserDefaults.standard.attraction = attraction.title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
