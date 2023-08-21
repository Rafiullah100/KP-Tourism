//
//  ExploreDistrictViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 6/22/23.
//

import UIKit
class ExploreDistrictViewController: BaseViewController {
    var districtCount: ((Int) -> Void)?

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ExploreTableViewCell", bundle: nil), forCellReuseIdentifier: ExploreTableViewCell.cellReuseIdentifier())
        }
    }
    //pagination
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    //explore
    public var exploreDistrict: [ExploreDistrict] = [ExploreDistrict]()
    var cellType: CellType?
    var sendExoloreDistrict: ((_ district: [ExploreDistrict]) -> Void)?
    var searchText: String?{
        didSet{
            print("erg ke rgkr4gt 4tg45h")
            exploreDistrict = []
            reloadData()
        }
    }
    var isDataLoaded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        cellType = .explore
        tableView.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(isDataLoaded)
        if isDataLoaded == false {
            reloadData()
        }
    }
        
    func reloadData(){
        print(searchText ?? "")
        fetchDistrict(parameters: ["search": searchText ?? "", "limit": limit, "user_id": UserDefaults.standard.userID ?? "", "page": currentPage])
    }
    
    func fetchDistrict(parameters: [String: Any]) {
       dataTask = URLSession.shared.request(route: .fetchExpolreDistrict, method: .post, parameters: parameters, model: ExploreModel.self) { result in
            switch result {
            case .success(let explore):
                self.exploreDistrict.append(contentsOf: explore.attractions)
                self.totalCount = explore.count ?? 0
                self.districtCount?(self.exploreDistrict.count)
                self.exploreDistrict.count == 0 ? self.tableView.setEmptyView("No District Found!") : self.tableView.setEmptyView("")
                self.isDataLoaded = true
                self.tableView.reloadData()

            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func toggleDistrictWishlistStatus(for indexPath: IndexPath) {
        var district = exploreDistrict[indexPath.row]
        district.isWished = district.isWished == 1 ? 0 : 1
        exploreDistrict[indexPath.row] = district
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    private func moveToDetail(index: Int){
        Switcher.goToDestination(delegate: self, type: .district, exploreDistrict: exploreDistrict[index])
    }
}


extension ExploreDistrictViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.exploreDistrict.count)
        return self.exploreDistrict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExploreTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ExploreTableViewCell
        cell.wishlistButtonTappedHandler = {
            self.toggleDistrictWishlistStatus(for: indexPath)
        }
        cell.configure(district: exploreDistrict[indexPath.row])
        cell.tappedHandler = {
            self.moveToDetail(index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(exploreDistrict.count, totalCount, indexPath.row, exploreDistrict.count - 1)
        if exploreDistrict.count != totalCount && indexPath.row == exploreDistrict.count - 1  {
            print(exploreDistrict.count, totalCount, indexPath.row)
            currentPage = currentPage + 1
            reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellType?.getHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToDetail(index: indexPath.row)
    }
}
    
