//
//  HomeViewController.swift
//  Tourism app
//
//  Created by Rafi on 10/10/2022.
//

import UIKit
import TabbedPageView
import MaterialComponents.MaterialTabs_TabBarView
import GoogleMaps

class HomeViewController: BaseViewController {

    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var tabbarView: MDCTabBarView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var mapButton: UIButton!
    
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var galleryContainer: UIView!
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            for type in CellType.allCases{
                tableView.registerNibForCellClass(type.getClass())
            }
        }
    }
    
    lazy var galleryVC: UIViewController = {
        UIStoryboard(name: "Gallery", bundle: nil).instantiateViewController(withIdentifier: "GalleryViewController")
    }()
    var mapVC: UIViewController {
        UIStoryboard(name: "MapView", bundle: nil).instantiateViewController(withIdentifier: "ExploreMapViewController")
    }
    
    var cellType: CellType?
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardHandleAreaHeight:CGFloat = 60
    
    var cardVisible = true
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    var section = [Sections]()
    var tabbarItems = [UITabBarItem]()
    var model: Codable?
    var totalPages: Int?
    var currentPage: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadow()
        type = .back1
        setupCard()
        configureTabbar()
        fetch(route: .fetchExpolreDistrict, method: .post, parameters: ["geoType": "northern"], model: ExploreModel.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let explore):
                DispatchQueue.main.async {
                    self.model = explore
                    self.tableView.reloadData()
                    self.showMap()
                }
            case .failure(let error):
                if error == .noInternet {
                    self.tableView.noInternet()
                }
            }
        }
    }
    
    private func showMap(){
        let camera = GMSCameraPosition.camera(withLatitude: 35.2227, longitude: 72.4258, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: mapContainerView.frame, camera: camera)
        mapView.delegate = self
        mapContainerView.addSubview(mapView)
    
        (model as? ExploreModel)?.attractions.rows.forEach({ district in
            let marker = GMSMarker()
            guard let latitude = Double(district.latitude ?? ""), let longitude = Double(district.longitude ?? "") else { return }
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.iconView = UIImageView(image: UIImage(named: "poi-map-icon"))
            marker.userData = district.id
            marker.map = mapView
        })
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellType == .explore {
            return (model as? ExploreModel)?.attractions.rows.count ?? 0
        }
        else if cellType == .event{
            return (model as? EventsModel)?.events.count ?? 0
        }
        else if cellType == .adventure{
            return (model as? AdventureModel)?.adventures.count ?? 0
        }
        else if cellType == .blog{
            return (model as? BlogsModel)?.blog.count ?? 0
        }
        else if cellType == .south{
            return (model as? ExploreModel)?.attractions.count ?? 0
        }
        else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellType == .explore {
            let cell: ExploreTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ExploreTableViewCell
            cell.district = (model as? ExploreModel)?.attractions.rows[indexPath.row]
            return cell
        }
        else if cellType == .attraction{
            let cell: AttractionTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! AttractionTableViewCell
            return cell
        }
        else if cellType == .event{
            let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! EventTableViewCell
            cell.event = (model as? EventsModel)?.events[indexPath.row]
            return cell
        }
        else if cellType == .adventure{
            let cell: AdventureTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! AdventureTableViewCell
            cell.adventure = (model as? AdventureModel)?.adventures[indexPath.row]
            return cell
        }
        else if cellType == .blog{
            let cell: BlogTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! BlogTableViewCell
            cell.blog = (model as? BlogsModel)?.blog[indexPath.row]
            return cell
        }
        else if cellType == .south{
            let cell: SouthTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! SouthTableViewCell
            cell.district = (model as? ExploreModel)?.attractions.rows[indexPath.row]
            return cell
        }
        else{
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "")!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellType?.getHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellType {
        case .explore:
            Switcher.goToDestination(delegate: self, type: .district, exploreDistrict: (model as! ExploreModel).attractions.rows[indexPath.row])
        case .event:
            Switcher.gotoEventDetail(delegate: self, event: (model as! EventsModel).events[indexPath.row])
        case .tour:
            Switcher.gotoPackageDetail(delegate: self)
        case .blog:
            Switcher.gotoBlogDetail(delegate: self, blogDetail: (model as! BlogsModel).blog[indexPath.row])
        case .product:
            Switcher.gotoProductDetail(delegate: self)
        case .adventure:
            Switcher.gotoAdventureDetail(delegate: self, adventure: (model as! AdventureModel).adventures[indexPath.row])
        case .attraction:
            Switcher.gotoGalleryDetail(delegate: self)
        default:
            break
        }
    }
}


extension HomeViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        if item.title == tabbarItems[5].title{
            galleryContainer.isHidden = false
            tableViewContainer.isHidden = true
        }
        else{
            galleryContainer.isHidden = true
            tableViewContainer.isHidden = false
        }
        addChild(title: item.title ?? "")
//        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        tableView.reloadData()
    }
    
    private func addChild(title: String){
        if title == tabbarItems[0].title {
            mapButton.isHidden = false
            cellType = .explore
            fetch(route: .fetchExpolreDistrict, method: .post, model: ExploreModel.self)
        }
        else if title == tabbarItems[1].title{
            mapButton.isHidden = false
            cellType = .attraction
            fetch(route: .attractionbyDistrict, method: .post, model: AttractionByDistrictModel.self)
        }
        else if title == tabbarItems[2].title{
            mapButton.isHidden = true
            cellType = .adventure
            fetch(route: .fetchAdventure, method: .get, model: AdventureModel.self)
        }
        else if title == tabbarItems[3].title{
            mapButton.isHidden = false
            cellType = .south
            fetch(route: .fetchExpolreDistrict, method: .post, parameters: ["geoType": "southern"], model: ExploreModel.self)
        }
        else if title == tabbarItems[4].title{
            mapButton.isHidden = true
            cellType = .tour
        }
        else if title == tabbarItems[5].title{
            mapButton.isHidden = true
            self.add(galleryVC, in: galleryContainer)
        }
        else if title == tabbarItems[6].title{
            mapButton.isHidden = false
            cellType = .arch
        }
        else if title == tabbarItems[7].title{
            mapButton.isHidden = false
            cellType = .event
            fetch(route: .fetchAllEvents, method: .get, model: EventsModel.self)
        }
        else if title == tabbarItems[8].title{
            mapButton.isHidden = true
            cellType = .blog
            fetch(route: .fetchBlogs, method: .post, model: BlogsModel.self)
        }
        else if title == tabbarItems[9].title{
            mapButton.isHidden = true
            cellType = .product
        }
    }
}

extension HomeViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.userData ?? 0)
        return true
    }
}
