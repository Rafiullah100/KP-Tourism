//
//  Switcher.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//


import Foundation
import UIKit
import JBTabBarAnimation
class Switcher {
    
    static func gotoHome(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.tabs.rawValue, bundle: nil).instantiateViewController(withIdentifier: "JBTabBarController") as! JBTabBarController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        delegate.present(nav, animated: false)
    }

    static func gotoOtpScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        delegate.present(vc, animated: true)
    }
    
    static func gotoCart(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoCartDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CartDetailViewController") as! CartDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoDeliverySchedule(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "DeliveryScheduleViewController") as! DeliveryScheduleViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoPaymentMethod(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PaymentMethodViewController") as! PaymentMethodViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoPaymentCard(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CardListViewController") as! CardListViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAddNewCard(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddNewCardViewController") as! AddNewCardViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAddressList(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddressListViewController") as! AddressListViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }

    static func gotoChooseLoc(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ChooseLocationViewController") as! ChooseLocationViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAddAddress(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoCancelOrder(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.order.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OrderCancelViewController") as! OrderCancelViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        delegate.present(vc, animated: true)
    }
    
    static func gotoOrderSuccess(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OrderSuccessViewController") as! OrderSuccessViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        delegate.present(vc, animated: true)
    }
    
    static func gotoCurrentOrder(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.order.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CurrentOrderDetailViewController") as! CurrentOrderDetailViewController
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoCompletedOrder(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.order.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompletedOrderViewController") as! CompletedOrderViewController
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoDate(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "DateViewController") as! DateViewController
        vc.delegate = delegate as? any DateDelegate
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        delegate.present(vc, animated: true)
    }
    
    static func gotoWishlist(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MyWishlistViewController") as! MyWishlistViewController
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)

    }
    
    static func gotoProductDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.product.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoGallery(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.product.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProductGalleryViewController") as! ProductGalleryViewController
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .automatic
        delegate.present(vc, animated: false)
    }
    
    static func gotoUpdateProfile(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "UpdateProfileViewController") as! UpdateProfileViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        delegate.present(nav, animated: false)
    }
    
    static func gotoLanguage(delegate: UIViewController){
        
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LanguagePopUpViewController") as! LanguagePopUpViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        delegate.present(vc, animated: true)
    }
    
    static func logout(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: false)
    }
    
    static func gotoNotification(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: false)
    }
}
