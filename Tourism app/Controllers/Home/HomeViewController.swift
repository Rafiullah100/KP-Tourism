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
    
    @IBOutlet weak var galleryContainer: UIView!
    
    @IBOutlet weak var siteLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    lazy var galleryVC: UIViewController = {
        UIStoryboard(name: "Gallery", bundle: nil).instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
    }()
    lazy var mapVC: ExploreMapViewController = {
        UIStoryboard(name: "MapView", bundle: nil).instantiateViewController(withIdentifier: "ExploreMapViewController") as! ExploreMapViewController
    }()
    lazy var exploreVC: ExploreDistrictViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "ExploreDistrictViewController") as! ExploreDistrictViewController
    }()
    lazy var kpInvestmentVC: InvestKpViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "InvestKpViewController") as! InvestKpViewController
    }()
    lazy var packageVC: PackageViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "PackageViewController") as! PackageViewController
    }()
    lazy var archeologyVC: ArcheologyViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "ArcheologyViewController") as! ArcheologyViewController
    }()
    lazy var eventVC: EventViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
    }()
    lazy var blogVC: BlogViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "BlogViewController") as! BlogViewController
    }()
    lazy var productVC: ProductViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
    }()
    lazy var visitVC: VisitViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "VisitViewController") as! VisitViewController
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
    var exploreDistricts: [ExploreDistrict]?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBgView.viewShadow()
        notificationView.viewShadow()
        textField.inputAccessoryView = UIView()
        textField.delegate = self
        shadow()
        type = .back1
        setupCard()
        configureTabbar()
        cellType = .explore
        show(exploreVC, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
        vc == mapVC ? add(vc, in: mapContainerView) : add(vc, in: galleryContainer)
    }
}

extension HomeViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        galleryContainer.isHidden = false
        textField.text = ""
        addChild(tag: item.tag)
        mapButton.isHidden = item.tag == 0 ? false : true
        self.contentView.frame.origin.y = 0
        cardVisible = true
    }
    
    private func addChild(tag: Int){
        mapButton.isHidden = true
        if tag == 0 {
            cellType = .explore
            mapButton.isHidden = false
            show(exploreVC, sender: self)
        }
        else if tag == 1{
            cellType = .investment
            show(kpInvestmentVC, sender: self)
        }
        else if tag == 2{
            cellType = .tour
            show(packageVC, sender: self)
        }
        else if tag == 3{
            cellType = nil
            show(galleryVC, sender: self)
        }
        else if tag == 4{
            cellType = .arch
            show(archeologyVC, sender: self)
        }
        else if tag == 5{
            cellType = .event
            show(eventVC, sender: self)
        }
        else if tag == 6{
            cellType = .blog
            show(blogVC, sender: self)
        }
        else if tag == 7{
            cellType = .product
            show(productVC, sender: self)
        }
        else if tag == 8{
            cellType = nil
            show(visitVC, sender: self)
        }
        setupCard()
    }
}

extension HomeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if cellType == .explore {
            exploreVC.searchText = textField.text
        }
        else if cellType == .investment{
            kpInvestmentVC.searchText = textField.text
        }
        else if cellType == .tour{
            packageVC.searchText = textField.text
        }
        else if cellType == .arch{
            archeologyVC.searchText = textField.text
        }
        else if cellType == .event{
            eventVC.searchText = textField.text
        }
        else if cellType == .blog{
            blogVC.searchText = textField.text
        }
        else if cellType == .product{
            productVC.searchText = textField.text
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if cellType == .explore {
            exploreVC.searchText = ""
        }
        else if cellType == .investment{
            kpInvestmentVC.searchText = ""
        }
        else if cellType == .tour{
            packageVC.searchText = ""
        }
        else if cellType == .arch{
            archeologyVC.searchText = ""
        }
        else if cellType == .event{
            eventVC.searchText = ""
        }
        else if cellType == .blog{
            blogVC.searchText = ""
        }
        else if cellType == .product{
            productVC.searchText = ""
        }
        textField.resignFirstResponder()
        return true
    }
}
