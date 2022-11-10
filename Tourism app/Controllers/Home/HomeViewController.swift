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

    var tabs: [Tab]?
    
    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var tabbarView: MDCTabBarView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mapContainerView: UIView!

    lazy var exploreVC: UIViewController = {
        let vc: ExploreViewController = UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "ExploreViewController") as! ExploreViewController
        return vc
    }()
    lazy var attractionVC: UIViewController = {
        let vc: AttractionsViewController = UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "AttractionsViewController") as! AttractionsViewController
        vc.delegate = self
        return vc
    }()
    
    lazy var adventureVC: UIViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "AdventureViewController")
    }()
    lazy var southVC: UIViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "SouthViewController")
    }()
    lazy var tourVC: UIViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "TourViewController")
    }()
    lazy var event: UIViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "HomeEventsViewController")
    }()
    lazy var blogVC: UIViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "BlogsViewController")
    }()
    lazy var productVC: UIViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController")
    }()
    lazy var galleryVC: UIViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "GalleryViewController")
    }()
    lazy var mapVC: UIViewController = {
        UIStoryboard(name: "MapView", bundle: nil).instantiateViewController(withIdentifier: "ExploreMapViewController")
    }()
    lazy var archVC: UIViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "ArcheologyViewController")
    }()
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadow()
        type = .back1
        setupCard()
        configureTabbar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureTabbar(){
        tabbarView.items = [
          UITabBarItem(title: "Explore", image: UIImage(named: "explore"), selectedImage: UIImage(named: "explore-s")),
          UITabBarItem(title: "Attractions", image: UIImage(named: "attraction"), selectedImage: UIImage(named: "attraction-s")),
          UITabBarItem(title: "Adventure", image: UIImage(named: "adventure"), selectedImage: UIImage(named: "adventure-s")),
          UITabBarItem(title: "South KP", image: UIImage(named: "south"), selectedImage: UIImage(named: "south-s")),
          UITabBarItem(title: "Tour Packages", image: UIImage(named: "tour"), selectedImage: UIImage(named: "tour-s")),
          UITabBarItem(title: "Gallery", image: UIImage(named: "gallery"), selectedImage: UIImage(named: "gallery-s")),
          UITabBarItem(title: "Archeology", image: UIImage(named: "arch"), selectedImage: UIImage(named: "arch-s")),
          UITabBarItem(title: "Events", image: UIImage(named: "event"), selectedImage: UIImage(named: "event-s")),
          UITabBarItem(title: "Blogs", image: UIImage(named: "blog"), selectedImage: UIImage(named: "blog-s")),
          UITabBarItem(title: "Local Products", image: UIImage(named: "product"), selectedImage: UIImage(named: "product-s")),
        ]
        tabbarView.selectedItem = tabbarView.items[0]
        tabbarView.bottomDividerColor = .groupTableViewBackground
        tabbarView.rippleColor = .clear
        tabbarView.selectionIndicatorStrokeColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
        tabbarView.preferredLayoutStyle = .scrollableCentered
        tabbarView.isScrollEnabled = true
        tabbarView.setTitleFont(UIFont(name: "Roboto-Light", size: 12.0), for: .normal)
        tabbarView.setTitleFont(UIFont(name: "Roboto-Medium", size: 12.0), for: .selected)
        tabbarView.setTitleColor(.darkGray, for: .normal)
        tabbarView.setTitleColor(Constants.appColor, for: .selected)
        tabbarView.tabBarDelegate = self
        tabbarView.minItemWidth = 10
        self.add(mapVC, in: mapContainerView)
        self.add(exploreVC, in: contentView)
    }
    
    func shadow()  {
        notificationView.layer.cornerRadius = notificationView.frame.size.height * 0.5
        notificationView.layer.shadowColor = UIColor.lightGray.cgColor
        notificationView.layer.shadowOffset = CGSize(width: 1, height: 1)
        notificationView.layer.shadowOpacity = 0.4
        notificationView.layer.shadowRadius = 2.0
    }
    
    func setupCard() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        contentView.addGestureRecognizer(panGestureRecognizer)
        self.view.bringSubviewToFront(topView)
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: contentView)
        var fractionComplete = translation.y / contentView.frame.height
        fractionComplete = cardVisible ? fractionComplete : -fractionComplete
        print("fractionComplete: \(translation.y)")
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            if nextState == .collapsed {
                if translation.y > 10 {
                    continueInteractiveTransition()
                }
            }
            else{
                let name = Notification.Name(Constants.enableScrolling)
                NotificationCenter.default.post(name: name, object: nil)
                continueInteractiveTransition()
            }
            
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.contentView.frame.origin.y = 0
                case .collapsed:
                    self.contentView.frame.origin.y = self.contentView.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.contentView.roundCorners(corners: [.topRight, .topLeft], radius: 20.0)
                case .collapsed:
                    self.contentView.roundCorners(corners: [.topRight, .topLeft], radius: 20.0)
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    @IBAction func notificattionButtonAction(_ sender: Any) {
    }
}

extension HomeViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        addChild(title: item.title ?? "")
    }
    
    private func addChild(title: String){
//        self.remove(from: container)
        if title == "Explore" {
            self.add(exploreVC, in: contentView)
        }
        else if title == "Attractions"{
            self.add(attractionVC, in: contentView)
        }
        else if title == "Adventure"{
            self.add(adventureVC, in: contentView)
        }
        else if title == "South KP"{
            self.add(southVC, in: contentView)
        }
        else if title == "Tour Packages"{
            self.add(tourVC, in: contentView)
        }
        else if title == "Gallery"{
            self.add(galleryVC, in: contentView)
        }
        else if title == "Archeology"{
            self.add(archVC, in: contentView)
        }
        else if title == "Events"{
            self.add(event, in: contentView)
        }
        else if title == "Blogs"{
            self.add(blogVC, in: contentView)
        }
        else if title == "Local Products"{
            self.add(productVC, in: contentView)
        }
    }
}

extension HomeViewController: Dragged{

    func isDragged() {
        animateTransitionIfNeeded(state: .collapsed, duration: 0.9)
    }
}
