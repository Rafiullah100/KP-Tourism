//
//  HomeViewController.swift
//  Tourism app
//
//  Created by Rafi on 10/10/2022.
//

import UIKit
import TabbedPageView
import MaterialComponents.MaterialTabs_TabBarView
//import GoogleMaps
import SVProgressHUD
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
    
    @IBOutlet weak var textField: UITextField!
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
    lazy var mapVC: UIViewController = {
        UIStoryboard(name: "MapView", bundle: nil).instantiateViewController(withIdentifier: "ExploreMapViewController") as! ExploreMapViewController
    }()
    
    var cellType: CellType?
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardHandleAreaHeight: CGFloat = 60
    
    var cardVisible = true
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    var section = [Sections]()
    var tabbarItems = [UITabBarItem]()
    var model: Codable?
    
    //pagination
    var totalCount = 1
    var currentPage = 1
    var limit = 5
    //explore
    var exploreDistrict: [ExploreDistrict] = [ExploreDistrict]()
    var attractionDistrict: [AttractionsDistrict] = [AttractionsDistrict]()
    var localProducts: [LocalProduct] = [LocalProduct]()
    var event: [EventListModel] = [EventListModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBgView.viewShadow()
        notificationView.viewShadow()
        textField.inputAccessoryView = UIView()
        textField.delegate = self
        tableView.keyboardDismissMode = .onDrag
        shadow()
        type = .back1
        cellType = .explore
        setupCard()
        configureTabbar()
        serverCall(cell: .explore)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let explore):
                self.model = explore
                if self.cellType == .explore {
                    self.exploreDistrict.append(contentsOf: (explore as? ExploreModel)?.attractions ?? [])
                    self.totalCount = (explore as? ExploreModel)?.count ?? 0
                    print(self.totalCount)
                }
                else if self.cellType == .attraction{
                    self.attractionDistrict.append(contentsOf: (explore as? AttractionModel)?.attractions?.rows ?? [])
                    self.totalCount = (explore as? AttractionModel)?.attractions?.count ?? 0
                }
                else if self.cellType == .product{
                    self.localProducts.append(contentsOf: (explore as? ProductModel)?.localProducts ?? [])
                    self.totalCount = (explore as? ProductModel)?.count ?? 0
                }
                else if self.cellType == .event{
                    self.event = (explore as? EventsModel)?.events ?? []
                }
                self.tableView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }

    override func show(_ vc: UIViewController, sender: Any?) {
        let vc: ExploreMapViewController = UIStoryboard(name: "MapView", bundle: nil).instantiateViewController(withIdentifier: "ExploreMapViewController") as! ExploreMapViewController
        vc.exploreDistrict = exploreDistrict
        add(vc, in: mapContainerView)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch cellType {
        case .explore:
            siteLabel.text = "\(exploreDistrict.count) Explore Sites"
            return exploreDistrict.count
        case .investment:
            return (model as? InvestmentModel)?.investments.rows.count ?? 0
        case .attraction:
            return attractionDistrict.count
        case .adventure:
            return (model as? AdventureModel)?.adventures.count ?? 0
        case .south:
            return (model as? ExploreModel)?.attractions.count ?? 0
        case .tour:
            return (model as? TourModel)?.tour.count ?? 0
        case .event:
            return (model as? EventsModel)?.events.count ?? 0
        case .arch:
            return (model as? ArcheologyModel)?.archeology?.count ?? 0
        case .blog:
            return (model as? BlogsModel)?.blog.count ?? 0
        case .product:
            return localProducts.count
        case .visitKP:
            return (model as? VisitKPModel)?.attractions.rows.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellType {
        case .explore:
            let cell: ExploreTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ExploreTableViewCell
            cell.district = exploreDistrict[indexPath.row]
            cell.actionBlock = {
                self.like(route: .likeApi, method: .post, parameters: ["section_id": self.exploreDistrict[indexPath.row].id, "section": "district"], model: SuccessModel.self, exploreCell: cell)
            }
            return cell
        case .investment:
            let cell: InvestmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! InvestmentTableViewCell
            cell.investment = (model as? InvestmentModel)?.investments.rows[indexPath.row]
            return cell
        case .attraction:
            let cell: AttractionTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! AttractionTableViewCell
            cell.attraction = attractionDistrict[indexPath.row]
            return cell
        case .adventure:
            let cell: AdventureTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! AdventureTableViewCell
            cell.adventure = (model as? AdventureModel)?.adventures[indexPath.row]
            return cell
        case .south:
            let cell: SouthTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! SouthTableViewCell
            cell.district = (model as? ExploreModel)?.attractions[indexPath.row]
            return cell
        case .tour:
            let cell: TourTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! TourTableViewCell
            cell.tour = (model as? TourModel)?.tour[indexPath.row]
            cell.actionBlock = {
                let packageID = (self.model as? TourModel)?.tour[indexPath.row].id
                self.like(route: .likeApi, method: .post, parameters: ["section_id": packageID ?? 0, "section": "tour_package"], model: SuccessModel.self, tourCell: cell)
            }
            return cell
        case .event:
            let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! EventTableViewCell
            cell.event = (model as? EventsModel)?.events[indexPath.row]
            return cell
        case .arch:
            let cell: ArchTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ArchTableViewCell
            cell.archeology = (model as? ArcheologyModel)?.archeology?[indexPath.row]
            cell.actionBlock = {
                let archeologyID = (self.model as? ArcheologyModel)?.archeology?[indexPath.row].id
                self.like(route: .likeApi, method: .post, parameters: ["section_id": archeologyID ?? 0, "section": "attraction"], model: SuccessModel.self, archeologyCell: cell)
            }
            return cell
        case .blog:
            let cell: BlogTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! BlogTableViewCell
            cell.blog = (model as? BlogsModel)?.blog[indexPath.row]
            return cell
        case .product:
            let cell: ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ProductTableViewCell
            cell.product = localProducts[indexPath.row]
            return cell
        case .visitKP:
            let cell: VisitKPTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! VisitKPTableViewCell
            cell.visit = (model as? VisitKPModel)?.attractions.rows[indexPath.row]
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
            Switcher.goToDestination(delegate: self, type: .district, exploreDistrict: exploreDistrict[indexPath.row])
        case .event:
            Switcher.gotoEventDetail(delegate: self, event: (model as! EventsModel).events[indexPath.row])
        case .tour:
            Switcher.gotoPackageDetail(delegate: self, tourDetail: (model as! TourModel).tour[indexPath.row])
        case .blog:
            Switcher.gotoBlogDetail(delegate: self, blogDetail: (model as! BlogsModel).blog[indexPath.row])
        case .product:
            Switcher.gotoProductDetail(delegate: self, product: localProducts[indexPath.row])
        case .adventure:
            Switcher.gotoAdventureDetail(delegate: self, adventure: (model as! AdventureModel).adventures[indexPath.row])
        case .attraction:
            Switcher.goToDestination(delegate: self, type: .tourismSpot, attractionDistrict: attractionDistrict[indexPath.row])
        case .south:
            Switcher.goToDestination(delegate: self, type: .district, exploreDistrict: (model as? ExploreModel)?.attractions[indexPath.row])
        case .visitKP:
            if (model as! VisitKPModel).attractions.rows[indexPath.row].isWizard == true {
                Switcher.gotoVisitKP(delegate: self)
            }
            else{
                Switcher.goToWizardVC(delegate: self, visitDetail: (model as! VisitKPModel).attractions.rows[indexPath.row])
            }
        case .investment:
            guard let urlString = (model as? InvestmentModel)?.investments.rows[indexPath.row].fileURL else {
                return
            }
            Switcher.gotoPDFViewer(delegate: self, url: urlString)
        case .arch:
            Switcher.goToDestination(delegate: self, type: .district, archeologyDistrict: (model as? ArcheologyModel)?.archeology?[indexPath.row])
        default:
            break
        }
    }
}


extension HomeViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        if item.tag == 3{
            galleryContainer.isHidden = false
            tableViewContainer.isHidden = true
        }
        else{
            galleryContainer.isHidden = true
            tableViewContainer.isHidden = false
        }
        addChild(tag: item.tag)
        tableView.reloadData()
    }
    
    private func addChild(tag: Int){
        attractionDistrict = []
        exploreDistrict = []
        localProducts = []
        currentPage = 1
        if tag == 0 {
            mapButton.isHidden = false
            cellType = .explore
            serverCall(cell: .explore)
        }
        //        else if title == tabbarItems[1].title{
        //            mapButton.isHidden = false
        //            cellType = .attraction
        //            fetch(route: .attractionbyDistrict, method: .post, parameters: ["type": "attraction", "limit": limit, "page": currentPage], model: AttractionModel.self)
        //        }
        //        else if title == tabbarItems[2].title{
        //            mapButton.isHidden = true
        //            cellType = .adventure
        //            fetch(route: .fetchAdventure, method: .get, model: AdventureModel.self)
        //        }
        //        else if title == tabbarItems[3].title{
        //            mapButton.isHidden = false
        //            cellType = .south
        //            fetch(route: .fetchExpolreDistrict, method: .post, parameters: ["geoType": "southern"], model: ExploreModel.self)
        //        }
        else if tag == 1{
            mapButton.isHidden = true
            cellType = .investment
            fetch(route: .fetchInvestment, method: .post, model: InvestmentModel.self)
        }
        else if tag == 2{
            mapButton.isHidden = true
            cellType = .tour
            fetch(route: .fetchTourPackage, method: .post, parameters: ["user_id": UserDefaults.standard.userID ?? ""], model: TourModel.self)
        }
        else if tag == 3{
            mapButton.isHidden = true
            self.add(galleryVC, in: galleryContainer)
            fetch(route: .fetchGallery, method: .post, model: GalleryModel.self)
        }
        else if tag == 4{
            mapButton.isHidden = true
            cellType = .arch
            fetch(route: .fetchArcheology, method: .post, parameters: ["limit": 30, "page": 1], model: ArcheologyModel.self)
        }
        else if tag == 5{
            mapButton.isHidden = true
            cellType = .event
            fetch(route: .fetchAllEvents, method: .get, parameters: ["user_id": UserDefaults.standard.userID ?? ""], model: EventsModel.self)
        }
        else if tag == 6{
            mapButton.isHidden = true
            cellType = .blog
            fetch(route: .fetchBlogs, method: .post, parameters: ["user_id": UserDefaults.standard.userID ?? ""], model: BlogsModel.self)
        }
        else if tag == 7{
            mapButton.isHidden = true
            cellType = .product
            fetch(route: .fetchProduct, method: .post, parameters: ["limit": limit, "page": currentPage, "user_id": UserDefaults.standard.userID ?? ""], model: ProductModel.self)
        }
        else if tag == 8{
            mapButton.isHidden = true
            cellType = .visitKP
            fetch(route: .fetchVisitKp, method: .post, model: VisitKPModel.self)
        }
        setupCard()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cellType == .explore{
            if exploreDistrict.count != totalCount && indexPath.row == exploreDistrict.count - 1  {
                currentPage = currentPage + 1
                serverCall(cell: .explore)
            }
        }
        else if cellType == .attraction{
            if attractionDistrict.count != totalCount && indexPath.row == attractionDistrict.count - 1  {
                currentPage = currentPage + 1
                fetch(route: .attractionbyDistrict, method: .post, parameters: ["type": "attraction", "limit": limit, "page": currentPage], model: AttractionModel.self)
            }
        }
        else if cellType == .product{
            if localProducts.count != totalCount && indexPath.row == localProducts.count - 1  {
                currentPage = currentPage + 1
                fetch(route: .fetchProduct, method: .post, parameters: ["limit": limit, "page": currentPage], model: ProductModel.self)
            }
        }
    }
    
    private func serverCall(cell: CellType){
        switch cell {
        case .explore:
            fetch(route: .fetchExpolreDistrict, method: .post, parameters: ["geoType": "northern,southern", "search": textField.text ?? "", "limit": limit, "user_id": UserDefaults.standard.userID ?? "", "page": currentPage], model: ExploreModel.self)
        default: break
            //ejnre
        }
    }
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, exploreCell: ExploreTableViewCell? = nil, tourCell: TourTableViewCell? = nil, archeologyCell: ArchTableViewCell? = nil) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let like):
                let successDetail = like as? SuccessModel
                if  self.cellType == .explore{
                    exploreCell?.favoriteButton.setBackgroundImage(successDetail?.message == "Liked" ? UIImage(named: "favorite") : UIImage(named: "unfavorite-gray"), for: .normal)
                }
                else if self.cellType == .tour{
                    tourCell?.favoriteButton.setBackgroundImage(successDetail?.message == "Liked" ? UIImage(named: "favorite") : UIImage(named: "unfavorite-gray"), for: .normal)
                }
                else if self.cellType == .arch{
                    archeologyCell?.favoriteButton.setBackgroundImage(successDetail?.message == "Liked" ? UIImage(named: "favorite") : UIImage(named: "unfavorite-gray"), for: .normal)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}


extension HomeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch cellType {
        case .explore:
            currentPage = 1
            exploreDistrict = []
            serverCall(cell: .explore)
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
