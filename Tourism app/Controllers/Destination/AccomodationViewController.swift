//
//  AccomodationViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

class AccomodationViewController: BaseViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "AccomodationTableViewCell", bundle: nil), forCellReuseIdentifier: AccomodationTableViewCell.celldentifier)
        }
    }
    var locationCategory: LocationCategory?

    
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var accomodationDetail: AccomodationModel?
    var archeology: Archeology?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
//        updateUI()
        
        var attractionID = 0
        
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
            attractionID = exploreDistrict?.id ?? 0
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
            attractionID = attractionDistrict?.id ?? 0
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.image_url ?? "")))
            attractionID = archeology?.id ?? 0
        }
        // id = 2
        fetch(route: .fetchAccomodation, method: .post, parameters: ["attraction_id": attractionID], model: AccomodationModel.self)

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
}

extension AccomodationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accomodationDetail?.accomodations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccomodationTableViewCell = tableView.dequeueReusableCell(withIdentifier: AccomodationTableViewCell.celldentifier) as! AccomodationTableViewCell
        cell.accomodationDetail = accomodationDetail?.accomodations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let accomodation = accomodationDetail?.accomodations[indexPath.row] else { return }
        Switcher.gotoAccomodationDetail(delegate: self, AccomodationDetail: accomodation)
    }
}

extension AccomodationViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150.0
    }
}
