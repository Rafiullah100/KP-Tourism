//
//  BaseViewController.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 06/12/21.
//

import UIKit
import SwiftUI

enum ViewControllerType {
    case home
    case title
    case back1
    case back2
}

class BaseViewController: UIViewController {
    var type: ViewControllerType = .back1
    var categoryId = ""
    var titleLabel: UILabel?
        
    var viewControllerTitle: String? {
        didSet {
            //titleLabel?.text = viewControllerTitle ?? ""
            switch type {
            case .home:
                addCenterLabel()
            default:
                break
            }
        }
    }
    
    func addCenterLabel() {
        titleLabel = UILabel()
        if let titleLabel = titleLabel {
            titleLabel.text = viewControllerTitle ?? ""
            titleLabel.font = UIFont(name: "Poppins-Medium", size: 21)
            titleLabel.textColor = UIColor.white
            
            self.navigationItem.titleView = titleLabel
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        solidNavigationBar()
        switch type {
        case .home:
            setupHomeBarButtonItems()
        case .title:
            setupTitleBarButtonItems()
        case .back1:
            setupBackBarButtonItemsWithFilterButton()
        case .back2:
            setupBackBarButtonItemsWithLikeButton()
        }
    }
    
    func solidNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
       if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
           appearance.backgroundColor = .clear
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
           navigationController?.navigationBar.frame = CGRect(x: 0, y: 30, width: navigationController?.navigationBar.frame.width ?? 0, height: (navigationController?.navigationBar.frame.height ?? 0) )
        }else{
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.frame = CGRect(x: 0, y: 30, width: navigationController?.navigationBar.frame.width ?? 0, height: (navigationController?.navigationBar.frame.height ?? 0) )
        }
    }
    
    func setupHomeBarButtonItems() {
        navigationItem.leftBarButtonItems = []
        navigationItem.rightBarButtonItems = []
    }
    
    func setupTitleBarButtonItems() {
        navigationItem.leftBarButtonItems = []
        addTitleLabel()
        navigationItem.rightBarButtonItems = []
        addCrossButton()
    }
    
    func setupBackBarButtonItemsWithLikeButton() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addBackButton()
        shareFavoriteBtns()
    }
    
    func setupBackBarButtonItemsWithFilterButton() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addBackButton()
        shareFilterBtns()
    }
    
    func addTitleLabel() {
        titleLabel = UILabel()
        if let titleLabel = titleLabel {
            titleLabel.text = "Log in or Sign up"
            titleLabel.font = UIFont(name: "Roboto-Bold", size: 18)
            titleLabel.textColor = UIColor.black
            self.navigationItem.titleView = titleLabel
        }
    }

    func addBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        backButton.image = nil
        backButton.image = UIImage(named: "Back")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func addCrossButton() {
        let crossButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        crossButton.image = nil
        crossButton.image = UIImage(named: "cross")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = crossButton
    }
    
    func shareFavoriteBtns() {
        let shareButton = UIButton()
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let shareItem = UIBarButtonItem()
        shareItem.customView = shareButton
        
        let likeButton = UIButton()
        likeButton.setImage(UIImage(named: "favorite"), for: .normal)
        likeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let likeItem = UIBarButtonItem()
        likeItem.customView = likeButton
        self.navigationItem.rightBarButtonItems = [shareItem, likeItem]
    }
    
    func shareFilterBtns() {
        let filterButton = UIButton()
        filterButton.setImage(UIImage(named: "filter"), for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let shareItem = UIBarButtonItem()
        filterButton.addTarget(self, action: #selector(showFilter), for: .touchUpInside)
        shareItem.customView = filterButton
        
        let likeButton = UIButton()
        likeButton.setImage(UIImage(named: "favorite"), for: .normal)
        likeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let likeItem = UIBarButtonItem()
        likeItem.customView = likeButton
        self.navigationItem.rightBarButtonItems = [shareItem, likeItem]
    }
    
    @objc func showFilter(){
//        delegate?.showPopup()
    }
    
    @objc func backButtonAction() {
        if let _ = navigationController?.popViewController(animated: true) {
        } else {
            navigationController?.tabBarController?.selectedIndex = 0
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func backAction() {
        if let _ = navigationController?.popViewController(animated: true) {
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}


