//
//  AccomodationViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit
import SVProgressHUD
import MaterialComponents.MaterialTabs_TabBarView

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
    @IBOutlet weak var tabbar: MDCTabBarView!
    var locationCategory: LocationCategory?

    
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var accomodationDetail: AccomodationModel?
    var archeology: Archeology?
    var tabbarItems = [UITabBarItem]()

    var hotelTypes = ["camping_pods", "government_rest_houses", "private_hotels"]
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
//        updateUI()
        configureTab()
        reloadAccomodation(type: hotelTypes[0])
    }
    
    private func reloadAccomodation(type: String){
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(route: .fetchDistrictAccomodation, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0, "bookStayType": type], model: AccomodationModel.self)
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnailBottomLabel.text = attractionDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
            fetch(route: .fetchAttrctionAccomodation, method: .post, parameters: ["attraction_id": attractionDistrict?.id ?? 0, "bookStayType": type], model: AccomodationModel.self)
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnailBottomLabel.text = archeology?.attractions.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
            fetch(route: .fetchAttrctionAccomodation, method: .post, parameters: ["attraction_id": archeology?.attractions.id ?? 0, "bookStayType": type], model: AccomodationModel.self)
        }
    }
    
    private func configureTab(){
        var tag = -1
        for item in Constants.accomodationSection {
            tag = tag + 1
            let tabbarItem = UITabBarItem(title: item.title, image:  UIImage(named: item.image), tag: tag)
            tabbarItems.append(tabbarItem)
        }
        tabbar.tabBarDelegate = self
        tabbar.delegate = self
        Helper.shared.customTab(tabbar: tabbar, items: tabbarItems)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tabbar {
            Helper.shared.disableVerticalScrolling(tabbar)
        }
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let accomodation):
                DispatchQueue.main.async {
                    self.accomodationDetail = accomodation as? AccomodationModel
                    
                    if self.accomodationDetail?.accomodations.count == 0{
                        self.tableView.setEmptyView("No Accomodation found!")
                    }
                    else{
                        self.tableView.setEmptyView("")
                    }
                    self.tableView.reloadData()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
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
            return 280.0
    }
}

extension AccomodationViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        print(item.tag)
        reloadAccomodation(type: hotelTypes[item.tag])
    }
}
