//
//  DestinationDetailViewController.swift
//  Tourism app
//
//  Created by Rafi on 15/11/2022.
//
import UIKit
import TabbedPageView
import MaterialComponents.MaterialTabs_TabBarView
import SwiftGifOrigin
//protocol PopupDelegate {
//    func showPopup()
//}

class DestinationDetailViewController: BaseViewController {
        
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabbarView: MDCTabBarView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var filterView: FilterView!
    
    lazy var attractionVC: UIViewController = {
        let vc: AttractionViewController = UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "AttractionViewController") as!
        AttractionViewController
//        delegate = vc as PopupDelegate
        return vc
    }()
    
    lazy var gettingHereVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "GettingHereViewController")
    }()
    lazy var interestingVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "InterestPointViewController")
    }()
    lazy var aboutVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "AboutViewController")
    }()

//    var delegate: PopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .back1
        configureTabbar()
    }
    
    private func configureTabbar(){
        tabbarView.items = [
            UITabBarItem(title: "What to See", image: UIImage(), tag: 0),
            UITabBarItem(title: "Getting Here", image: UIImage(), tag: 1),
            UITabBarItem(title: "Point of Interest", image: UIImage(), tag: 2),
            UITabBarItem(title: "About", image: UIImage(), tag: 7)
        ]
        tabbarView.selectedItem = tabbarView.items[0]
        tabbarView.bottomDividerColor = .groupTableViewBackground
        tabbarView.rippleColor = .clear
        tabbarView.selectionIndicatorStrokeColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
        tabbarView.preferredLayoutStyle = .scrollableCentered
        tabbarView.isScrollEnabled = false
        tabbarView.setTitleFont(UIFont(name: "Poppins-Light", size: 14.0), for: .normal)
        tabbarView.setTitleFont(UIFont(name: "Poppins-Medium", size: 14.0), for: .selected)
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

extension DestinationDetailViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        addChild(tag: item.tag)
    }
    
    private func addChild(tag: Int){
        if tag == 0 {
            type = .back1
//            self.delegate = attractionVC as? PopupDelegate
            self.add(attractionVC, in: contentView)
        }
        else if tag == 1{
            type = .back1
            self.add(gettingHereVC, in: contentView)
        }
        else if tag == 2{
            type = .back1
            self.add(interestingVC, in: contentView)
        }
        else if tag == 3{
            type = .back2
            self.add(aboutVC, in: contentView)
        }
    }
}

