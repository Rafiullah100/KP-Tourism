//
//  PackageViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 6/22/23.
//

import UIKit

class PackageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "TourTableViewCell", bundle: nil), forCellReuseIdentifier: TourTableViewCell.cellReuseIdentifier())
        }
    }
    
    //pagination
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    //explore
    var tourPackage: [TourPackage] = [TourPackage]()
    var searchText: String?{
        didSet{
            tourPackage = []
            reloadData()
        }
    }
    var cellType: CellType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        cellType = .tour
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let modelObject = DataManager.shared.packageModelObject,
           let index = tourPackage.firstIndex(where: { $0.id == modelObject.id }) {
            tourPackage[index] = modelObject
            tableView.reloadData()
        }
    }
    
    private func reloadData(){
        fetchPackages(parameters: ["limit": limit, "page": currentPage, "user_id": UserDefaults.standard.userID ?? "", "uuid": UserDefaults.standard.uuid ?? "", "search": searchText ?? ""])
    }

    func fetchPackages(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchTourPackage, method: .post, parameters: parameters, model: TourModel.self) { result in
            switch result {
            case .success(let package):
                self.tourPackage.append(contentsOf: package.tour)
                self.totalCount = package.count ?? 0
                print(self.tourPackage.count)
                self.totalCount == 0 ? self.tableView.setEmptyView("No Tour Package Found!") : self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func toggleTourWishlistStatus(for indexPath: IndexPath) {
        var tour = tourPackage[indexPath.row]
        tour.userWishlist = tour.userWishlist == 1 ? 0 : 1
        tourPackage[indexPath.row] = tour
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}


extension PackageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tourPackage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TourTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! TourTableViewCell
        cell.wishlistButtonTappedHandler = {
            self.toggleTourWishlistStatus(for: indexPath)
        }
        cell.configure(tour: tourPackage[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tourPackage.count != totalCount && indexPath.row == tourPackage.count - 1  {
            currentPage = currentPage + 1
            reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellType?.getHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoPackageDetail(delegate: self, tourDetail: tourPackage[indexPath.row], type: .list)
    }
}
