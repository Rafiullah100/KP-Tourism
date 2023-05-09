//
//  TourAccomodationViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/30/23.
//

import UIKit

class TravelAccomodation: UITableViewCell {
    //
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var selectedImgView: UIImageView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imageBGView: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedImgView.isHidden = selected ? false : true
    }
    
    var accomodation: Accomodation?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (accomodation?.previewImage ?? "")))
            label.text = accomodation?.title
            
            bottomView.clipsToBounds = true
            bottomView.layer.cornerRadius = 10
            bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

            imageBGView.clipsToBounds = true
            imageBGView.layer.cornerRadius = 10
            imageBGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomView.viewShadow()
        }
    }
}

class TourAccomodationViewController: BaseViewController {
  
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var isSelected: Bool?
    var accomodationDetail: AccomodationModel?
    var districtID: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .visitKP
        viewControllerTitle = "Tour Planner"
        //id 2
        fetch(route: .fetchAccomodation, method: .post, parameters: ["attraction_id": districtID ?? 0], model: AccomodationModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let accomodation):
                DispatchQueue.main.async {
                    self.accomodationDetail = accomodation as? AccomodationModel
                    self.accomodationDetail?.accomodations.count == 0 ? self.tableView.setEmptyView() : self.tableView.reloadData()
                }
            case .failure(let error):
                if error == .noInternet {
                    self.tableView.noInternet()
                }
            }
        }
    }

    
    @IBAction func forwardBtnAction(_ sender: Any) {
        if isSelected == true{
            Switcher.gotoTourpdfVC(delegate: self)
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension TourAccomodationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accomodationDetail?.accomodations.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TravelAccomodation = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! TravelAccomodation
        cell.accomodation = accomodationDetail?.accomodations[indexPath.row]
//        cell.travel = Constants.traveleAccomodation[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSelected = true
        UserDefaults.standard.accomodation = accomodationDetail?.accomodations[indexPath.row].title
//        if let encoded = try? JSONEncoder().encode( accomodationDetail?.accomodations[indexPath.row]) {
//            UserDefaults.standard.set(encoded, forKey: "accomodation")
//        }
    }
}


