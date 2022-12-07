//
//  Switcher.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import Foundation
import UIKit

class Switcher {
    
    
    static func goToTabbar(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: false)
    }
    
    static func gotoAbout(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToDestination(delegate: UIViewController, type: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CommonViewController") as! CommonViewController
        vc.locationCategory = type
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToPOIServices(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.POI.rawValue, bundle: nil).instantiateViewController(withIdentifier: "POIServicesViewController") as! POIServicesViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToPOIMap(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.POI.rawValue, bundle: nil).instantiateViewController(withIdentifier: "POIMapViewController") as! POIMapViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToNavigation(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "NavigationViewController") as! NavigationViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToAttraction(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AttractionViewController") as! AttractionViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToGettingHere(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "GettingHereViewController") as! GettingHereViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }

    static func goToPOI(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PointOfInterestViewController") as! PointOfInterestViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToAccomodation(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AccomodationViewController") as! AccomodationViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToEvents(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToItinrary(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ItenrariesViewController") as! ItenrariesViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToProducts(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LocalProductsViewController") as! LocalProductsViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoGallery(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.gallery.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoGalleryDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.gallery.rawValue, bundle: nil).instantiateViewController(withIdentifier: "GalleryDetailViewController") as! GalleryDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
//    static func gotoTourismSpot(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TourismSpotViewController") as! TourismSpotViewController
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
    
//    static func gotoFilterVC(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.popup.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.modalTransitionStyle = .crossDissolve
//        delegate.present(vc, animated: true, completion: nil)
//    }
    
    static func gotoServicesVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.POI.rawValue, bundle: nil).instantiateViewController(withIdentifier: "POIServicesViewController") as! POIServicesViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        delegate.present(vc, animated: true, completion: nil)
    }
    
    static func gotoEventDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoBlogDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "BlogDetailViewController") as! BlogDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoProductDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAdventureDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AdventureDetailViewController") as! AdventureDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoPackageDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PackageDetailViewController") as! PackageDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoDestDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "DestinationDetailViewController") as! DestinationDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoNotificationVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.navigationBar.isHidden = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToSignupVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToLoginVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToFeedsVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FeedsViewController") as! FeedsViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToChatListVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ChatListViewController") as! ChatListViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToProfileVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func showFollower(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProfilePopUpViewController") as! ProfilePopUpViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        delegate.present(vc, animated: true, completion: nil)
    }
}

