//
//  HomeViewController+Extension.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/20/22.
//

import Foundation
import UIKit
extension HomeViewController: UIScrollViewDelegate{
    
    func configureTabbar(){
        var tag = 0
        for item in Constants.section {
            let tabbarItem = UITabBarItem(title: item.title, image: UIImage(named: item.image), selectedImage: UIImage(named: item.selectedImage))
            tabbarItem.tag = tag
            tag = tag + 1
            tabbarItems.append(tabbarItem)
        }
        tabbarView.tabBarDelegate = self
        tabbarView.delegate = self
        Helper.shared.customTab(tabbar: tabbarView, items: tabbarItems)
        show(mapVC, sender: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tabbarView {
            Helper.shared.disableVerticalScrolling(tabbarView)
        }
    }
    
    func shadow()  {
        notificationView.layer.shadowColor = UIColor.lightGray.cgColor
        notificationView.layer.shadowOffset = CGSize(width: 1, height: 1)
        notificationView.layer.shadowOpacity = 0.4
        notificationView.layer.shadowRadius = 2.0
    }
    
    func setupCard() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
//        if cellType == .explore{
            contentView.addGestureRecognizer(panGestureRecognizer)
//        }
//        else{
//            contentView.removeGestureRecognizer(panGestureRecognizer)
//        }
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
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.mapButton.isHidden = false
                    self.contentView.frame.origin.y = 0
                case .collapsed:
                    self.show(self.mapVC, sender: self)
                    self.mapButton.isHidden = true
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
        mapVC.exploreDistrict = exploreVC.exploreDistrict
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
