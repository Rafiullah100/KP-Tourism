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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadow()
        type = .back1
        setupCard()
        configureTabbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureTabbar(){
        section = [Sections(title: "Explore", image: "explore", selectedImage: "explore-s"),
                   Sections(title: "Attractions", image: "attraction", selectedImage: "attraction-s"),
                   Sections(title: "Adventure", image: "adventure", selectedImage: "adventure-s"),
                   Sections(title: "South KP", image: "south", selectedImage: "south-s"),
                   Sections(title: "Tour Packages", image: "tour", selectedImage: "tour-s"),
                   Sections(title: "Gallery", image: "gallery", selectedImage: "gallery-s"),
                   Sections(title: "Archeology", image: "arch", selectedImage: "arch-s"),
                   Sections(title: "Events", image: "event", selectedImage: "event-s"),
                   Sections(title: "Blogs", image: "blog", selectedImage: "blog-s"),
                   Sections(title: "Local Products", image: "product", selectedImage: "product-s"),
        ]
        for item in section {
            let tabbarItem = UITabBarItem(title: item.title, image: UIImage(named: item.image), selectedImage: UIImage(named: item.selectedImage))
            tabbarItems.append(tabbarItem)
        }
        tabbarView.items = tabbarItems
        tabbarView.selectedItem = tabbarView.items[0]
        tabbarView.bottomDividerColor = .groupTableViewBackground
        tabbarView.rippleColor = .clear
        tabbarView.selectionIndicatorStrokeColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
        tabbarView.preferredLayoutStyle = .scrollableCentered
        tabbarView.isScrollEnabled = false
        tabbarView.setTitleFont(UIFont(name: "Roboto-Light", size: 12.0), for: .normal)
        tabbarView.setTitleFont(UIFont(name: "Roboto-Medium", size: 12.0), for: .selected)
        tabbarView.setTitleColor(.darkGray, for: .normal)
        tabbarView.setTitleColor(Constants.appColor, for: .selected)
        tabbarView.tabBarDelegate = self
        tabbarView.minItemWidth = 10
        self.add(mapVC, in: mapContainerView)
        cellType = .explore
        galleryContainer.isHidden = true
    }
    
    func shadow()  {
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
                mapButton.isHidden = true
            }
            else{
                let name = Notification.Name(Constants.enableScrolling)
                NotificationCenter.default.post(name: name, object: nil)
                continueInteractiveTransition()
                mapButton.isHidden = false
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
    @IBAction func mapBtnAction(_ sender: Any) {
        switch nextState {
        case .expanded:
            mapButton.isHidden = false
//            animateTransitionIfNeeded(state: .collapsed, duration: 0.9)
        case .collapsed:
            mapButton.isHidden = true
            animateTransitionIfNeeded(state: .collapsed, duration: 0.9)
        }
    }
    @IBAction func notificationBtnAction(_ sender: Any) {
        Switcher.gotoNotificationVC(delegate: self)
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
            cellType = .explore
        }
        else if title == tabbarItems[1].title{
            cellType = .attraction
        }
        else if title == tabbarItems[2].title{
            cellType = .adventure
        }
        else if title == tabbarItems[3].title{
            cellType = .south
        }
        else if title == tabbarItems[4].title{
            cellType = .tour
        }
        else if title == tabbarItems[5].title{
            self.add(galleryVC, in: galleryContainer)
        }
        else if title == tabbarItems[6].title{
            cellType = .arch
        }
        else if title == tabbarItems[7].title{
            cellType = .event
        }
        else if title == tabbarItems[8].title{
            cellType = .blog
        }
        else if title == tabbarItems[9].title{
            cellType = .product
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "")
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellType?.getHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.goToDestinationHome(delegate: self)
    }
}
