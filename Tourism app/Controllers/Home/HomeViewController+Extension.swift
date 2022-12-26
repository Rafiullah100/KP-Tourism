//
//  HomeViewController+Extension.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/20/22.
//

import Foundation
import UIKit
extension HomeViewController{
    
    func configureTabbar(){
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
