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
    
    static func goToDestination(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "DestinatonViewController") as! DestinatonViewController
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
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
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
}
