//
//  ArcheologyViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 6/22/23.
//

import UIKit

class ArcheologyViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ArchTableViewCell", bundle: nil), forCellReuseIdentifier: ArchTableViewCell.cellReuseIdentifier())
        }
    }
    
    //pagination
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    //explore
    var archeology: [Archeology] = [Archeology]()
    var searchText: String?{
        didSet{
            archeology = []
            reloadData()
        }
    }
    var cellType: CellType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellType = .arch
        reloadData()
    }

    private func reloadData(){
        fetchPackages(parameters: ["limit": limit, "page": currentPage, "search": searchText ?? "", "user_id": UserDefaults.standard.userID ?? ""])
    }

    func fetchPackages(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchArcheology, method: .post, parameters: parameters, model: ArcheologyModel.self) { result in
            switch result {
            case .success(let archeology):
                self.archeology.append(contentsOf: archeology.archeology)
                self.totalCount = archeology.count ?? 0
                self.totalCount == 0 ? self.tableView.setEmptyView("No Tour Package Found!") : self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func toggleArcheologyWishlistStatus(for indexPath: IndexPath) {
        var arch = archeology[indexPath.row]
        arch.attractions.isWished = arch.attractions.isWished == 1 ? 0 : 1
        archeology[indexPath.row] = arch
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}


extension ArcheologyViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.archeology.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArchTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ArchTableViewCell
        cell.wishlistButtonTappedHandler={
            self.toggleArcheologyWishlistStatus(for: indexPath)
        }
        cell.configure(archeology: archeology[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if archeology.count != totalCount && indexPath.row == archeology.count - 1  {
            currentPage = currentPage + 1
            reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellType?.getHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.goToDestination(delegate: self, type: .district, archeologyDistrict: archeology[indexPath.row])
    }
}
