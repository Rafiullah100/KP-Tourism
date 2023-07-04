//
//  EventsViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 6/22/23.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: EventTableViewCell.cellReuseIdentifier())
        }
    }
    
    //pagination
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    //explore
    var event: [EventListModel] = [EventListModel]()
    var searchText: String?{
        didSet{
            event = []
            reloadData()
        }
    }
    var cellType: CellType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        cellType = .event
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let modelObject = DataManager.shared.eventModelObject,
           let index = event.firstIndex(where: { $0.id == modelObject.id }) {
            event[index] = modelObject
            tableView.reloadData()
        }
    }

    private func reloadData(){
        fetchevents(parameters: ["limit": limit, "page": currentPage, "search": searchText ?? "", "user_id": UserDefaults.standard.userID ?? "", "uuid": UserDefaults.standard.uuid ?? ""])
    }

    func fetchevents(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchAllEvents, method: .post, parameters: parameters, model: EventsModel.self) { result in
            switch result {
            case .success(let event):
                self.event.append(contentsOf: event.events)
                self.totalCount = event.count
                self.totalCount == 0 ? self.tableView.setEmptyView("No Event Found!") : self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func toggleEventWishlistStatus(for indexPath: IndexPath) {
        var eventObject = event[indexPath.row]
        eventObject.userWishlist = eventObject.userWishlist == 1 ? 0 : 1
        event[indexPath.row] = eventObject
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}


extension EventViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.event.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! EventTableViewCell
        cell.event = event[indexPath.row]
        cell.wishlistButtonTappedHandler = {
            self.toggleEventWishlistStatus(for: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if event.count != totalCount && indexPath.row == event.count - 1  {
            currentPage = currentPage + 1
            reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellType?.getHeight() ?? 0.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoEventDetail(delegate: self, event: event[indexPath.row], type: .list)
    }
}
