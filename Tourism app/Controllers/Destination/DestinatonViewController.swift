//
//  AttractionViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import TabbedPageView
import MaterialComponents.MaterialTabs_TabBarView
import SwiftGifOrigin
protocol PopupDelegate {
    func showPopup()
}

class DestinatonViewController: BaseViewController {
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabbarView: MDCTabBarView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var filterView: FilterView!
    
    lazy var attractionVC: UIViewController = {
        let vc: AttractionViewController = UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "AttractionViewController") as!
        AttractionViewController
        delegate = vc as PopupDelegate
        return vc
    }()
    
    lazy var gettingHereVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "GettingHereViewController")
    }()
    lazy var interestingVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "InterestPointViewController")
    }()
    lazy var eventVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "EventsViewController")
    }()
    lazy var productVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "LocalProductsViewController")
    }()
    lazy var itenrariesVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "ItenrariesViewController")
    }()
    lazy var accomodationVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "AccomodationViewController")
    }()
    lazy var aboutVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "AboutViewController")
    }()

    var delegate: PopupDelegate?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        
        type = .back1
        configureTabbar()
    }
    
    private func configureTabbar(){
        tabbarView.items = [
            UITabBarItem(title: "Attractions", image: UIImage(), tag: 0),
            UITabBarItem(title: "Getting Here", image: UIImage(), tag: 1),
            UITabBarItem(title: "Point of Interest", image: UIImage(), tag: 2),
            UITabBarItem(title: "Events", image: UIImage(), tag: 3),
            UITabBarItem(title: "Local Products", image: UIImage(), tag: 4),
            UITabBarItem(title: "Itenraries", image: UIImage(), tag: 5),
            UITabBarItem(title: "Accomodation", image: UIImage(), tag: 6),
            UITabBarItem(title: "About", image: UIImage(), tag: 7)
        ]
        tabbarView.selectedItem = tabbarView.items[0]
        tabbarView.bottomDividerColor = .groupTableViewBackground
        tabbarView.rippleColor = .clear
        tabbarView.selectionIndicatorStrokeColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
        tabbarView.preferredLayoutStyle = .scrollableCentered
        tabbarView.isScrollEnabled = false
        tabbarView.setTitleFont(UIFont(name: "Roboto-Light", size: 14.0), for: .normal)
        tabbarView.setTitleFont(UIFont(name: "Roboto-Medium", size: 14.0), for: .selected)
        tabbarView.setTitleColor(.darkGray, for: .normal)
        tabbarView.setTitleColor(Constants.appColor, for: .selected)
        tabbarView.tabBarDelegate = self
        tabbarView.minItemWidth = 10
        self.add(attractionVC, in: contentView)
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    override func showFilter() {
//        delegate?.showPopup()
        filterView.isHidden = !filterView.isHidden
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension DestinatonViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        addChild(tag: item.tag)
    }
    
    private func addChild(tag: Int){
        if tag == 0 {
            self.shareFavoriteBtns(type: .Setting)
            self.delegate = attractionVC as? PopupDelegate
            self.add(attractionVC, in: contentView)
        }
        else if tag == 1{
            self.shareFavoriteBtns(type: .Setting)
            self.add(gettingHereVC, in: contentView)
        }
        else if tag == 2{
            self.shareFavoriteBtns(type: .Setting)
            self.add(interestingVC, in: contentView)
        }
        else if tag == 3{
            self.shareFavoriteBtns(type: .upload)
            self.add(eventVC, in: contentView)
        }
        else if tag == 4{
            self.shareFavoriteBtns(type: .upload)
            self.add(productVC, in: contentView)
        }
        else if tag == 5{
            self.shareFavoriteBtns(type: .upload)
            self.add(itenrariesVC, in: contentView)
        }
        else if tag == 6{
            self.shareFavoriteBtns(type: .upload)
            self.add(accomodationVC, in: contentView)
        }
        else if tag == 7{
            self.shareFavoriteBtns(type: .upload)
            self.add(aboutVC, in: contentView)
        }
    }
}

