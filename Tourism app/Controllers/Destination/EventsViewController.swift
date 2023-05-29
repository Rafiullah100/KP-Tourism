//
//  EventsViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import SVProgressHUD
class EventsViewController: BaseViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: EventTableViewCell.cellReuseIdentifier())
        }
    }
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var eventDetail: EventsModel?
    var archeology: Archeology?
    var wishlistAttraction: WishlistAttraction?
    var wishlistDistrict: WishlistDistrict?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(route: .fetchEventsByDistrict, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0], model: EventsModel.self)
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
            fetch(route: .fetchEventsByDistrict, method: .post, parameters: ["district_id": attractionDistrict?.districtID ?? 0], model: EventsModel.self)
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnailBottomLabel.text = archeology?.attractions.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
            fetch(route: .fetchEventsByDistrict, method: .post, parameters: ["district_id": archeology?.attractions.districtID ?? 0], model: EventsModel.self)
        }
        else if wishlistAttraction != nil{
            thumbnailTopLabel.text = wishlistAttraction?.title
            thumbnailBottomLabel.text = wishlistAttraction?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistAttraction?.displayImage ?? "")))
            fetch(route: .fetchEventsByDistrict, method: .post, parameters: ["district_id": wishlistAttraction?.districtID ?? 0], model: EventsModel.self)
        }
        if wishlistDistrict != nil {
            thumbnailTopLabel.text = wishlistDistrict?.title
            thumbnailBottomLabel.text = wishlistDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistDistrict?.previewImage ?? "")))
            fetch(route: .fetchEventsByDistrict, method: .post, parameters: ["district_id": wishlistDistrict?.id ?? 0], model: EventsModel.self)
        }
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let events):
                self.eventDetail = events as? EventsModel
                self.eventDetail?.events.count == 0 ? self.tableView.setEmptyView("No Event Found!") : self.tableView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}

extension EventsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventDetail?.events.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as! EventTableViewCell
        cell.event = eventDetail?.events[indexPath.row]
        return cell
    }
}

extension EventsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let event = eventDetail?.events[indexPath.row] else { return }
        Switcher.gotoEventDetail(delegate: self, event: event)
    }
}
