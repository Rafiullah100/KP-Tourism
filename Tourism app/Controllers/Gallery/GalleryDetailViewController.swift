//
//  GalleryDetailViewController.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import UIKit
import MaterialComponents.MaterialTabs_TabBarView

class GalleryDetailViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var tabbarView: MDCTabBarView!
    
    
    lazy var imageVC: UIViewController = {
        self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController")
    }()!
    lazy var videoVC: UIViewController = {
        self.storyboard?.instantiateViewController(withIdentifier: "VideoViewController")
    }()!
    lazy var tourVC: UIViewController = {
        self.storyboard?.instantiateViewController(withIdentifier: "VirtualTourViewController")
    }()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .back1
        configureTab()
    }
    
    private func configureTab(){
        tabbarView.items = [
          UITabBarItem(title: "Images", image: UIImage(named: ""), tag: 0),
          UITabBarItem(title: "Videos", image: UIImage(named: ""), tag: 1),
          UITabBarItem(title: "Virtual Tours", image: UIImage(named: ""), tag: 2),
        ]
        tabbarView.selectedItem = tabbarView.items[0]
        tabbarView.selectionIndicatorStrokeColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
        tabbarView.preferredLayoutStyle = .fixed
        tabbarView.isScrollEnabled = false
        tabbarView.setTitleFont(UIFont(name: "Roboto-Light", size: 12.0), for: .normal)
        tabbarView.setTitleFont(UIFont(name: "Roboto-Medium", size: 12.0), for: .selected)
        tabbarView.setTitleColor(.darkGray, for: .normal)
        tabbarView.setTitleColor(Constants.appColor, for: .selected)
        tabbarView.tabBarDelegate = self
        tabbarView.minItemWidth = 10
        self.add(imageVC, in: containerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       //
    }
}

extension GalleryDetailViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        addChild(tag: item.tag)
    }
    
    private func addChild(tag: Int){
//        self.remove(from: containerView)
        if tag == 0 {
            self.add(imageVC, in: containerView)
        }
        else if tag == 1{
            self.add(videoVC, in: containerView)
        }
        else if tag == 2{
            self.add(tourVC, in: containerView)
        }
    }
}
