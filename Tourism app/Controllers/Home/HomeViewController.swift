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
    
    @IBOutlet weak var topLabel: UILabel!
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
    var limit = 30
    //explore
    var exploreDistrict: [ExploreDistrict] = [ExploreDistrict]()
    var attractionDistrict: [AttractionsDistrict] = [AttractionsDistrict]()
    var localProducts: [LocalProduct] = [LocalProduct]()
    var event: [EventListModel] = [EventListModel]()
    var archeology: [Archeology] = [Archeology]()
    var tourPackage: [TourPackage] = [TourPackage]()
//    var event: [EventListModel] = [EventListModel]()
    var blogs: [Blog] = [Blog]()
    var investment: [InvestmentRow] = [InvestmentRow]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(UserDefaults.standard.uuid ?? "")
//        print(UserDefaults.standard.accessToken ?? "")
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
        print(UserDefaults.standard.accessToken ?? "")
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
                    self.exploreDistrict.append(contentsOf: (self.model as? ExploreModel)?.attractions ?? [])
                    self.totalCount = (self.model as? ExploreModel)?.count ?? 0
                }
                else if self.cellType == .attraction{
                    self.attractionDistrict.append(contentsOf: (self.model as? AttractionModel)?.attractions?.rows ?? [])
                    self.totalCount = (self.model as? AttractionModel)?.attractions?.count ?? 0
                }
                else if self.cellType == .product{
                    self.localProducts.append(contentsOf: (self.model as? ProductModel)?.localProducts ?? [])
                    self.totalCount = (self.model as? ProductModel)?.count ?? 0
                }
                else if self.cellType == .event{
                    let eventModel = self.model as? EventsModel
                    self.event.append(contentsOf: eventModel?.events ?? [])
                    self.totalCount = eventModel?.count ?? 0
                }
                else if self.cellType == .arch{
                    self.archeology.append(contentsOf: (self.model as? ArcheologyModel)?.archeology ?? [])
                    self.totalCount = (self.model as? ArcheologyModel)?.count ?? 0
                    print(self.totalCount, (self.model as? ArcheologyModel)?.archeology.count ?? 0)
                }
                else if self.cellType == .tour{
                    self.tourPackage.append(contentsOf: (self.model as? TourModel)?.tour ?? [])
                    self.totalCount = (self.model as? TourModel)?.count ?? 0
                }
                else if self.cellType == .blog{
                    self.blogs.append(contentsOf: (self.model as? BlogsModel)?.blog ?? [])
                    self.totalCount = (self.model as? BlogsModel)?.count ?? 0
                }
                else if self.cellType == .investment{
                    self.investment.append(contentsOf: (self.model as? InvestmentModel)?.investments?.rows ?? [])
                    self.totalCount = (self.model as? InvestmentModel)?.investments?.count ?? 0
                }
                if self.totalCount == 0{
                    self.tableView.setEmptyView("No Record found!")
                }
                else{
                    self.tableView.backgroundView = nil
                }
                self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }

    @IBAction func bookBtnAction(_ sender: Any) {
        if let url = URL(string: Constants.bookingStay) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func helplineBtnAction(_ sender: Any) {
        Switcher.gotoWeatherVC(delegate: self, type: .weather)
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        let vc: ExploreMapViewController = UIStoryboard(name: "MapView", bundle: nil).instantiateViewController(withIdentifier: "ExploreMapViewController") as! ExploreMapViewController
        vc.exploreDistrict = exploreDistrict
        add(vc, in: mapContainerView)
    }
    
    func emptyArray() {
        exploreDistrict = []
        localProducts = []
        archeology = []
        tourPackage = []
        event = []
        blogs = []
        investment = []
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch cellType {
        case .explore:
            siteLabel.text = "\(exploreDistrict.count) Explore Sites"
            return exploreDistrict.count
        case .investment:
            return investment.count
        case .attraction:
            return attractionDistrict.count
        case .adventure:
            return (model as? AdventureModel)?.adventures.count ?? 0
        case .south:
            return (model as? ExploreModel)?.attractions.count ?? 0
        case .tour:
            return tourPackage.count
        case .event:
            return event.count
        case .arch:
            return archeology.count
        case .blog:
            return blogs.count
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
                self.wishList(route: .doWishApi, method: .post, parameters: ["section_id": self.exploreDistrict[indexPath.row].id ?? 0, "section": "district"], model: SuccessModel.self, exploreCell: cell)
            }
            return cell
        case .investment:
            let cell: InvestmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! InvestmentTableViewCell
            cell.investment = investment[indexPath.row]
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
            cell.tour = tourPackage[indexPath.row]
            cell.actionBlock = {
                let packageID = self.tourPackage[indexPath.row].id
                self.wishList(route: .doWishApi, method: .post, parameters: ["section_id": packageID ?? 0, "section": "tour_package"], model: SuccessModel.self, tourCell: cell)
            }
            return cell
        case .event:
            let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! EventTableViewCell
            cell.event = event[indexPath.row]
            return cell
        case .arch:
            let cell: ArchTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ArchTableViewCell
            cell.archeology = archeology[indexPath.row]
            cell.actionBlock = {
                let archeologyID = self.archeology[indexPath.row].attractions.id
                self.wishList(route: .doWishApi, method: .post, parameters: ["section_id": archeologyID ?? 0, "section": "attraction"], model: SuccessModel.self, archeologyCell: cell)
            }
            return cell
        case .blog:
            let cell: BlogTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! BlogTableViewCell
            cell.blog = blogs[indexPath.row]
            return cell
        case .product:
            let cell: ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ProductTableViewCell
            cell.product = localProducts[indexPath.row]
            cell.actionBlock = {
                self.wishList(route: .doWishApi, method: .post, parameters: ["section_id": self.localProducts[indexPath.row].id, "section": "local_product"], model: SuccessModel.self, productCell: cell)
            }
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
            Switcher.gotoEventDetail(delegate: self, event: event[indexPath.row])
        case .tour:
            Switcher.gotoPackageDetail(delegate: self, tourDetail: tourPackage[indexPath.row], type: .list)
        case .blog:
            Switcher.gotoBlogDetail(delegate: self, blogDetail: blogs[indexPath.row])
        case .product:
            Switcher.gotoProductDetail(delegate: self, product: localProducts[indexPath.row], type: .list)
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
            guard let urlString = investment[indexPath.row].fileURL else {
                return
            }
            Switcher.gotoPDFViewer(delegate: self, url: urlString)
        case .arch:
            Switcher.goToDestination(delegate: self, type: .district, archeologyDistrict: archeology[indexPath.row])
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
        topLabel.text = Constants.section[item.tag].title
        textField.text = ""
        addChild(tag: item.tag)
        
        mapButton.isHidden = item.tag == 0 ? false : true
        self.contentView.frame.origin.y = 0
    }
    
    private func addChild(tag: Int){
        emptyArray()
        currentPage = 1
        if tag == 0 {
            mapButton.isHidden = false
            cellType = .explore
            serverCall(cell: .explore)
        }
        else if tag == 1{
            mapButton.isHidden = true
            cellType = .investment
            serverCall(cell: .investment)
        }
        else if tag == 2{
            mapButton.isHidden = true
            cellType = .tour
            serverCall(cell: .tour)
        }
        else if tag == 3{
            mapButton.isHidden = true
            cellType = nil
            self.add(galleryVC, in: galleryContainer)
            fetch(route: .fetchGallery, method: .post, model: GalleryModel.self)
        }
        else if tag == 4{
            mapButton.isHidden = true
            cellType = .arch
            serverCall(cell: .arch)
        }
        else if tag == 5{
            mapButton.isHidden = true
            cellType = .event
            serverCall(cell: .event)
        }
        else if tag == 6{
            mapButton.isHidden = true
            cellType = .blog
            serverCall(cell: .blog)
        }
        else if tag == 7{
            mapButton.isHidden = true
            cellType = .product
            serverCall(cell: .product)
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
            }
        }
        else if cellType == .product{
            if localProducts.count != totalCount && indexPath.row == localProducts.count - 1  {
                currentPage = currentPage + 1
                serverCall(cell: .product)
            }
        }
        else if cellType == .arch{
            if archeology.count != totalCount && indexPath.row == archeology.count - 1  {
                currentPage = currentPage + 1
                serverCall(cell: .arch)
            }
        }
        else if cellType == .tour{
            if tourPackage.count != totalCount && indexPath.row == tourPackage.count - 1  {
                currentPage = currentPage + 1
                serverCall(cell: .tour)
            }
        }
        else if cellType == .event{
            if event.count != totalCount && indexPath.row == event.count - 1  {
                currentPage = currentPage + 1
                serverCall(cell: .tour)
            }
        }
        else if cellType == .blog{
            if blogs.count != totalCount && indexPath.row == blogs.count - 1  {
                currentPage = currentPage + 1
                serverCall(cell: .blog)
            }
        }
        else if cellType == .investment{
            if investment.count != totalCount && indexPath.row == investment.count - 1  {
                currentPage = currentPage + 1
                serverCall(cell: .investment)
            }
        }
    }
    
    private func serverCall(cell: CellType){
        switch cell {
        case .explore:
            fetch(route: .fetchExpolreDistrict, method: .post, parameters: ["geoType": "northern,southern", "search": textField.text ?? "", "limit": limit, "user_id": UserDefaults.standard.userID ?? "", "page": currentPage], model: ExploreModel.self)
        case .investment:
            fetch(route: .fetchInvestment, method: .post, parameters: ["limit": limit, "page": currentPage, "search": textField.text ?? ""], model: InvestmentModel.self)
        case .tour:
            fetch(route: .fetchTourPackage, method: .post, parameters: ["limit": limit, "page": currentPage, "user_id": UserDefaults.standard.userID ?? "", "uuid": UserDefaults.standard.uuid ?? "", "search": textField.text ?? ""], model: TourModel.self)
        case .arch:
            fetch(route: .fetchArcheology, method: .post, parameters: ["limit": limit, "page": currentPage, "search": textField.text ?? "", "user_id": UserDefaults.standard.userID ?? ""], model: ArcheologyModel.self)
        case .event:
            fetch(route: .fetchAllEvents, method: .post, parameters: ["limit": limit, "page": currentPage, "search": textField.text ?? "", "user_id": UserDefaults.standard.userID ?? "", "uuid": UserDefaults.standard.uuid ?? ""], model: EventsModel.self)
        case .blog:
            fetch(route: .fetchBlogs, method: .post, parameters: ["limit": limit, "page": currentPage, "user_id": UserDefaults.standard.userID ?? "", "search": textField.text ?? ""], model: BlogsModel.self)
        case .product:
            fetch(route: .fetchProduct, method: .post, parameters: ["limit": limit, "page": currentPage, "user_id": UserDefaults.standard.userID ?? "", "search": textField.text ?? ""], model: ProductModel.self)
        default: break
            //ejnre
        }
    }
    
    func wishList<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, exploreCell: ExploreTableViewCell? = nil, tourCell: TourTableViewCell? = nil, archeologyCell: ArchTableViewCell? = nil, productCell: ProductTableViewCell? = nil) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let wish):
                let successDetail = wish as? SuccessModel
                if  self.cellType == .explore{
                    exploreCell?.favoriteButton.setBackgroundImage(successDetail?.message == "Wishlist Added" ? UIImage(named: "fav") : UIImage(named: "unfavorite-gray"), for: .normal)
                }
                else if self.cellType == .tour{
                    tourCell?.favoriteButton.setBackgroundImage(successDetail?.message == "Wishlist Added" ? UIImage(named: "fav") : UIImage(named: "unfavorite-gray"), for: .normal)
                }
                else if self.cellType == .arch{
                    archeologyCell?.favoriteButton.setBackgroundImage(successDetail?.message == "Wishlist Added" ? UIImage(named: "fav") : UIImage(named: "unfavorite-gray"), for: .normal)
                }
                else if self.cellType == .product{
                    productCell?.favouriteButton.setBackgroundImage(successDetail?.message == "Wishlist Added" ? UIImage(named: "fav") : UIImage(named: "unfavorite-gray"), for: .normal)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}


extension HomeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emptyArray()
        currentPage = 1
        serverCall(cell: cellType ?? .explore)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        emptyArray()
        currentPage = 1
        serverCall(cell: cellType ?? .explore)
        textField.resignFirstResponder()
        return true
    }
}
