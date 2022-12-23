//
//  HomeViewController.swift
//  Tourism app
//
//  Created by Rafi on 10/10/2022.
//

import UIKit
import TabbedPageView
import MaterialComponents.MaterialTabs_TabBarView

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadow()
        type = .back1
        setupCard()
        configureTabbar()
        fetch(route: .fetchExpolreDistrict, method: .post, model: ExploreModel.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func fetch<T: Codable>(route: Route, method: Method, model: T.Type) {
        URLSession.shared.request(route: route, method: method, model: model) { result in
            switch result {
            case .success(let explore):
                DispatchQueue.main.async {
                    self.model = explore
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellType == .explore {
            return (model as? ExploreModel)?.attractions.rows.count ?? 0
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
            Switcher.gotoEventDetail(delegate: self)
        case .tour:
            Switcher.gotoPackageDetail(delegate: self)
        case .blog:
            Switcher.gotoBlogDetail(delegate: self)
        case .product:
            Switcher.gotoProductDetail(delegate: self)
        case .adventure:
            Switcher.gotoAdventureDetail(delegate: self)
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
        }
        else if title == tabbarItems[2].title{
            mapButton.isHidden = true
            cellType = .adventure
        }
        else if title == tabbarItems[3].title{
            mapButton.isHidden = false
            cellType = .south
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
        }
        else if title == tabbarItems[8].title{
            mapButton.isHidden = true
            cellType = .blog
        }
        else if title == tabbarItems[9].title{
            mapButton.isHidden = true
            cellType = .product
        }
    }
}
