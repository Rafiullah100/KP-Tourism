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
    case title1
    case back1
    case back2
    case backWithTitle
    case notification
    case visitKP
}

enum RightButttonsType {
    case Setting
    case upload
}


class BaseViewController: UIViewController {
    var type: ViewControllerType = .back1
    var categoryId = ""
    var titleLabel: UILabel?
    var showfilterButton = true
    
    var viewControllerTitle: String? {
        didSet {
            titleLabel?.text = viewControllerTitle ?? ""
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
            titleLabel.textColor = Helper.shared.backgroundColor()
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
        case .title1:
            setupTitleBarButtonItems1()
        case .back1:
            setupBackBarButtonItemsWithFilterButton()
        case .back2:
            setupBackBarButtonItemsWithLikeButton()
        case .backWithTitle:
            setupBackButtonWithTitle()
        case .notification:
            setupBackButton()
        case .visitKP:
            setupBackToHome()
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
           navigationController?.navigationBar.frame = CGRect(x: navigationController?.navigationBar.frame.origin.x ?? 0, y: navigationController?.navigationBar.frame.origin.y ?? 0, width: navigationController?.navigationBar.frame.width ?? 0, height: (navigationController?.navigationBar.frame.height ?? 0) )
           //y = 20
        }else{
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.frame = CGRect(x: navigationController?.navigationBar.frame.origin.x ?? 0, y: navigationController?.navigationBar.frame.origin.y ?? 0, width: navigationController?.navigationBar.frame.width ?? 0, height: (navigationController?.navigationBar.frame.height ?? 0) )
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
    
    func setupTitleBarButtonItems1() {
        navigationItem.leftBarButtonItems = []
        addTitleLabel()
        navigationItem.rightBarButtonItems = []
    }
    
    func setupBackBarButtonItemsWithLikeButton() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addBackButton()
        shareFavoriteBtns(type: .Setting)
    }
    
    func setupBackBarButtonItemsWithFilterButton() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addBackButton()
//        shareFilterBtns()
    }
    
    func setupBackButtonWithTitle() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addBackButtonWithTitle()
    }
    
    func setupBackButton() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addArrowBackButton()
    }
    
    func setupBackToHome() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        backToHome()
    }
    
    func addArrowBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        backButton.image = nil
        backButton.image = UIImage(named: "arrow-back")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func addTitleLabel() {
        titleLabel = UILabel()
        if let titleLabel = titleLabel {
            titleLabel.text = viewControllerTitle
            titleLabel.font = UIFont(name: "\(Constants.appFontName)-Medium", size: 17)
            titleLabel.textColor = Helper.shared.textColor()
            self.navigationItem.titleView = titleLabel
        }
    }
    
    func addBackButtonWithTitle() {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageView.image = UIImage(named: "Back")
        let labelbgView = UIView(frame: CGRect(x: 35, y: 0, width: UIScreen.main.bounds.width, height: 30))
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: UIScreen.main.bounds.width, height: 30))
        labelbgView.addSubview(label)
        let stringArray = viewControllerTitle?.split(separator: "|")
        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "\(Constants.appFontName)-Medium", size: 18) ?? UIFont()]
        let secondAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "\(Constants.appFontName)-Light", size: 12) ?? UIFont()]
        let firstString = NSMutableAttributedString(string: String("\(stringArray?[0].prefix(25) ?? "")"), attributes: firstAttributes)
        var secondString = NSAttributedString("")
        if stringArray?.count ?? 0 > 1{
            secondString = NSAttributedString(string: String("| \(stringArray?[1] ?? "")"), attributes: secondAttributes)
        }
        firstString.append(secondString)
        
        labelbgView.layer.cornerRadius = 3.0
        labelbgView.layer.masksToBounds = true
        labelbgView.backgroundColor = .black
        labelbgView.layer.opacity = 0.6
        label.attributedText = firstString
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        button.frame = buttonView.frame
        buttonView.addSubview(button)
        buttonView.addSubview(imageView)
        buttonView.addSubview(labelbgView)
        let barButton = UIBarButtonItem.init(customView: buttonView)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func backToHome() {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(backToParent), for: .touchUpInside)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = UIImage(named: "Back")
        imageView.contentMode = .scaleAspectFit
        let label = UILabel(frame: CGRect(x: 35, y: 0, width: 130, height: 30))
        label.textColor = .black
        label.text = viewControllerTitle
        label.font = UIFont(name: "Poppins-Medium", size: 18.0)
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 30))
        button.frame = buttonView.frame
        buttonView.addSubview(button)
        buttonView.addSubview(imageView)
        buttonView.addSubview(label)
        let barButton = UIBarButtonItem.init(customView: buttonView)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func backToParent() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

    func addBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        let rightButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(filterAction))
        rightButton.image = UIImage(named: "filter")
        backButton.image = UIImage(named: "Back")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = rightButton
        if #available(iOS 16.0, *) {
            self.navigationItem.rightBarButtonItem?.isHidden = showfilterButton
        } else {
            self.navigationItem.rightBarButtonItem = showfilterButton ? rightButton : nil
        }
    }
    
    func addCrossButton() {
        let crossButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(pop))
        crossButton.image = nil
        crossButton.image = UIImage(named: "arrow-back")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = crossButton
    }
    
    public func shareFavoriteBtns(type: RightButttonsType) {
        let shareButton = UIButton()
        switch type {
        case .Setting:
            shareButton.setImage(UIImage(named: "filter"), for: .normal)
        case .upload:
            shareButton.setImage(UIImage(named: "share"), for: .normal)
        }
        shareButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let shareItem = UIBarButtonItem()
        shareItem.customView = shareButton
        
        let likeButton = UIButton()
        likeButton.setImage(UIImage(named: "fav"), for: .normal)
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
        filterButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        shareItem.customView = filterButton
        
        let likeButton = UIButton()
        likeButton.setImage(UIImage(named: "fav"), for: .normal)
        likeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let likeItem = UIBarButtonItem()
        likeItem.customView = likeButton
        self.navigationItem.rightBarButtonItems = [shareItem, likeItem]
    }
    
    @objc func backButtonAction() {
        if let _ = navigationController?.popViewController(animated: true) {
        } else {
            navigationController?.tabBarController?.selectedIndex = 0
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func filterAction() {
        print("")
    }
    
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backAction() {
        if let _ = navigationController?.popViewController(animated: true) {
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}


