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
    
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    
    var eventsArray: [EventListModel] = [EventListModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        loadData()
    }
    
    private func loadData(){
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": exploreDistrict?.id ?? 0, "limit": limit, "page": currentPage])
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": attractionDistrict?.districtID ?? 0, "limit": limit, "page": currentPage])
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnailBottomLabel.text = archeology?.attractions.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
            fetch(parameters: ["district_id": archeology?.attractions.districtID ?? 0, "limit": limit, "page": currentPage])
        }
        else if wishlistAttraction != nil{
            thumbnailTopLabel.text = wishlistAttraction?.title
            thumbnailBottomLabel.text = wishlistAttraction?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistAttraction?.displayImage ?? "")))
            fetch(parameters: ["district_id": wishlistAttraction?.districtID ?? 0, "limit": limit, "page": currentPage])
        }
        if wishlistDistrict != nil {
            thumbnailTopLabel.text = wishlistDistrict?.title
            thumbnailBottomLabel.text = wishlistDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": wishlistDistrict?.id ?? 0, "limit": limit, "page": currentPage])
        }
    }
    
    func fetch(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchEventsByDistrict, method: .post, parameters: parameters, model: EventsModel.self) { result in
            switch result {
            case .success(let eventDetail):
                self.eventsArray.append(contentsOf: eventDetail.events)
                self.totalCount = eventDetail.count
                self.totalCount == 0 ? self.tableView.setEmptyView("No Event Found!") : self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

extension EventsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as! EventTableViewCell
        cell.event = eventsArray[indexPath.row]
        return cell
    }
}

extension EventsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoEventDetail(delegate: self, event: eventsArray[indexPath.row], type: .list)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if eventsArray.count != totalCount && indexPath.row == eventsArray.count - 1  {
            currentPage = currentPage + 1
            loadData()
        }
    }
}
