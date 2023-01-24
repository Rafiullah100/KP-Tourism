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
    
    @IBOutlet weak var siteLabel: UILabel!
    
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
    var mapVC: ExploreMapViewController {
        UIStoryboard(name: "MapView", bundle: nil).instantiateViewController(withIdentifier: "ExploreMapViewController") as! ExploreMapViewController
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
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
                    self.show(self.mapVC, sender: self)
                }
            case .failure(let error):
                if error == .noInternet {
                    self.tableView.noInternet()
                }
            }
        }
    }

    override func show(_ vc: UIViewController, sender: Any?) {
        let vc: ExploreMapViewController = UIStoryboard(name: "MapView", bundle: nil).instantiateViewController(withIdentifier: "ExploreMapViewController") as! ExploreMapViewController
        vc.exploreDistrict = (model as? ExploreModel)?.attractions.rows
        vc.attractionDistrict = (model as? AttractionModel)?.attractions.rows
        add(vc, in: mapContainerView)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch cellType {
        case .explore:
            siteLabel.text = "\((model as? ExploreModel)?.attractions.rows.count ?? 0) Explore Sites"
            return (model as? ExploreModel)?.attractions.rows.count ?? 0
        case .attraction:
            siteLabel.text = "\((model as? AttractionModel)?.attractions.rows.count ?? 0) Attraction Sites"
            return (model as? AttractionModel)?.attractions.rows.count ?? 0
        case .adventure:
            return (model as? AdventureModel)?.adventures.count ?? 0
        case .south:
            siteLabel.text = "\((model as? ExploreModel)?.attractions.rows.count ?? 0) South KP Sites"
            return (model as? ExploreModel)?.attractions.rows.count ?? 0
        case .tour:
            return (model as? TourModel)?.tour.count ?? 0
        case .event:
            siteLabel.text = "\((model as? EventsModel)?.events.count ?? 0)  Events"
            return (model as? EventsModel)?.events.count ?? 0
        case .arch:
            siteLabel.text = "\((model as? ArcheologyModel)?.archeology?.count ?? 0) Archeology Sites"
            return (model as? ArcheologyModel)?.archeology?.count ?? 0
        case .blog:
            return (model as? BlogsModel)?.blog.count ?? 0
        case .product:
            return (model as? ProductModel)?.localProducts.count ?? 0
        case .visitKP:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellType {
        case .explore:
            let cell: ExploreTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ExploreTableViewCell
            cell.district = (model as? ExploreModel)?.attractions.rows[indexPath.row]
            return cell
        case .attraction:
            let cell: AttractionTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! AttractionTableViewCell
            cell.attraction = (model as? AttractionModel)?.attractions.rows[indexPath.row]
            return cell
        case .adventure:
            let cell: AdventureTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! AdventureTableViewCell
            cell.adventure = (model as? AdventureModel)?.adventures[indexPath.row]
            return cell
        case .south:
            let cell: SouthTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! SouthTableViewCell
            cell.district = (model as? ExploreModel)?.attractions.rows[indexPath.row]
            return cell
        case .tour:
            let cell: TourTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! TourTableViewCell
            cell.tour = (model as? TourModel)?.tour[indexPath.row]
            return cell
        case .event:
            let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! EventTableViewCell
            cell.event = (model as? EventsModel)?.events[indexPath.row]
            return cell
        case .arch:
            let cell: ArchTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ArchTableViewCell
            cell.archeology = (model as? ArcheologyModel)?.archeology?[indexPath.row]
            return cell
        case .blog:
            let cell: BlogTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! BlogTableViewCell
            cell.blog = (model as? BlogsModel)?.blog[indexPath.row]
            return cell
        case .product:
            let cell: ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ProductTableViewCell
            cell.product = (model as? ProductModel)?.localProducts[indexPath.row]
            return cell
        case .visitKP:
            let cell: ExploreTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ExploreTableViewCell
            return cell
        default:
            return UITableViewCell()
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
            Switcher.gotoPackageDetail(delegate: self, tourDetail: (model as! TourModel).tour[indexPath.row])
        case .blog:
            Switcher.gotoBlogDetail(delegate: self, blogDetail: (model as! BlogsModel).blog[indexPath.row])
        case .product:
            Switcher.gotoProductDetail(delegate: self, product: (model as! ProductModel).localProducts[indexPath.row])
        case .adventure:
            Switcher.gotoAdventureDetail(delegate: self, adventure: (model as! AdventureModel).adventures[indexPath.row])
        case .attraction:
            Switcher.goToDestination(delegate: self, type: .tourismSpot, attractionDistrict: (model as! AttractionModel).attractions.rows[indexPath.row])
        case .south:
            Switcher.goToDestination(delegate: self, type: .district, exploreDistrict: (model as? ExploreModel)?.attractions.rows[indexPath.row])
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
        tableView.reloadData()
    }
    
    private func addChild(title: String){
        if title == tabbarItems[0].title {
            mapButton.isHidden = false
            cellType = .explore
            fetch(route: .fetchExpolreDistrict, method: .post, parameters: ["geoType": "northern"], model: ExploreModel.self)
        }
        else if title == tabbarItems[1].title{
            mapButton.isHidden = false
            cellType = .attraction
            fetch(route: .attractionbyDistrict, method: .post, parameters: ["type": "attraction"], model: AttractionModel.self)
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
            fetch(route: .fetchTourPackage, method: .get, model: TourModel.self)
        }
        else if title == tabbarItems[5].title{
            mapButton.isHidden = true
            self.add(galleryVC, in: galleryContainer)
            fetch(route: .fetchGallery, method: .post, model: GalleryModel.self)
        }
        else if title == tabbarItems[6].title{
            mapButton.isHidden = false
            cellType = .arch
            fetch(route: .fetchArcheology, method: .post, model: ArcheologyModel.self)
        }
        else if title == tabbarItems[7].title{
            mapButton.isHidden = false
            cellType = .event
            fetch(route: .fetchAllEvents, method: .get, model: EventsModel.self)
        }
        else if title == tabbarItems[8].title{
            mapButton.isHidden = true
            cellType = .explore
            fetch(route: .fetchExpolreDistrict, method: .post, parameters: ["geoType": "northern"], model: ExploreModel.self)
        }
        else if title == tabbarItems[9].title{
            mapButton.isHidden = true
            cellType = .blog
            fetch(route: .fetchBlogs, method: .post, model: BlogsModel.self)
        }
        else if title == tabbarItems[10].title{
            mapButton.isHidden = true
            cellType = .product
            fetch(route: .fetchProduct, method: .post, model: ProductModel.self)
        }
    }
}

extension HomeViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.userData ?? 0)
        return true
    }
}
