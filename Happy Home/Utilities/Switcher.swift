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
    
//    static func makeTenantAsInitial(delegate: UIViewController, userType: UserType, contact: String){
//        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantHomeViewController") as! TenantHomeViewController
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = vc
//        self.window?.makeKeyAndVisible()
//    }
    
//    static func gotoOtpScreen(delegate: UIViewController, userType: UserType, contact: String, otpType: OtpType, otp: String){
//        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
//        vc.userType = userType
//        vc.contact = contact
//        vc.otpType = otpType
//        vc.otp = otp
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoSigninScreen(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoSignupScreen(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoRegisterScreen(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoTenantScreen(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantHomeViewController") as! TenantHomeViewController
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
    static func gotoHome(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.tabs.rawValue, bundle: nil).instantiateViewController(withIdentifier: "JBTabBarController") as! JBTabBarController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        delegate.present(nav, animated: true)
    }
//    
//    static func gotoCompanyScreen(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyTabbarController") as! CompanyTabbarController
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoWorkerScreen(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkersHomeViewController") as! WorkersHomeViewController
//        
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoOwnerScreen(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkersHomeViewController") as! WorkersHomeViewController
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoTenantDetailScreen(delegate: UIViewController, complaintID: Int){
//        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantDetailViewController") as! TenantDetailViewController
//        vc.complaintID = complaintID
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoOwnerProperty(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PropertyViewController") as! PropertyViewController
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: false)
//    }
//    
//    static func gotoCompanyProfile(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProfileHomeViewController") as! ProfileHomeViewController
//        let nav = UINavigationController(rootViewController: vc)
//        
//        nav.modalPresentationStyle = .fullScreen
//        delegate.present(nav, animated: true)
//    }
//    
//    static func gotoLogin(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
//        vc.modalPresentationStyle = .fullScreen
//        let nav = UINavigationController(rootViewController: vc)
//        delegate.present(nav, animated: true)
//    }
//    
//    static func gotoTenantCompletedDetailScreen(delegate: UIViewController, complaintID: Int){
//        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantCompletedViewController") as! TenantCompletedViewController
//        vc.complaintID = complaintID
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoPendingDetail(delegate: UIViewController, complaintID: Int){
//        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyPendingController") as! CompanyPendingController
//        vc.complaintID = complaintID
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoAssignWorker(delegate: UIViewController, complaint: TenantComplaintDetail){
//        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyAssignViewController") as! CompanyAssignViewController
//        vc.complaint = complaint
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoCompletedDetail(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyCompletedViewController") as! CompanyCompletedViewController
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoWorkerDetailScreen(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkerDetailViewController") as! WorkerDetailViewController
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoWorkerOngoingDetailScreen(delegate: UIViewController, complaintID: Int){
//        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkerOngoingDetailViewController") as! WorkerOngoingDetailViewController
//        vc.complaintID = complaintID
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoWorkerPropertyDetail(delegate: UIViewController, property: Property){
//        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkerPropertyViewController") as! WorkerPropertyViewController
//        vc.propertyDetail = property
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoWorkerComplaintDetailScreen(delegate: UIViewController, complaintID: Int){
//        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkerDetailViewController") as! WorkerDetailViewController
//        vc.complaintID = complaintID
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoWorkerListScreen(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkersHomeViewController") as! WorkersHomeViewController
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoPropertyDetail(delegate: UIViewController, propertyDetail: PropertiesRow){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PropertyDetailViewController") as! PropertyDetailViewController
////        vc.propertyType = propertyType
////        vc.propertyID = propertyID
//        vc.propertyDetail = propertyDetail
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoSelfPropertyDetail(delegate: UIViewController, propertyDetail: PropertiesRow){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SelfPropertyDetailViewController") as! SelfPropertyDetailViewController
////        vc.propertyType = propertyType
////        vc.propertyID = propertyID
//        vc.propertyDetail = propertyDetail
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoRemoveTenant(delegate: UIViewController, flatDetail: FlatRow){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "RemoveTenanatViewController") as! RemoveTenanatViewController
//        vc.flatDetail = flatDetail
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoCompanyList(delegate: UIViewController, propertyID: Int, property: String){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyManagmentViewController") as! CompanyManagmentViewController
//        vc.propertyID = propertyID
//        vc.property = property
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoTenantList(delegate: UIViewController, propertyID: Int, property: String){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantsManagementViewController") as! TenantsManagementViewController
//        vc.propertyID = propertyID
//        vc.property = property
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoSelfList(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "BothPropertyViewController") as! BothPropertyViewController
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoFlatList(delegate: UIViewController, propertyID: Int, property: String){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FlatManagementViewController") as! FlatManagementViewController
//        vc.propertyID = propertyID
//        vc.property = property
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoAddTenant(delegate: UIViewController, flatID: Int, flatNumber: String){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddTenanToFlatViewController") as! AddTenanToFlatViewController
//        vc.flatID = flatID
//        vc.flatNumber = flatNumber
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoContactList(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ContactPersonViewController") as! ContactPersonViewController
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        nav.hidesBottomBarWhenPushed = false
//        delegate.present(nav, animated: true)
//    }
//    
//    static func gotoOwnerDetail(delegate: UIViewController, complaintID: Int){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OwnerDetailViewController") as! OwnerDetailViewController
////        vc.ownerComplaint = complaintType
//        vc.complaintID = complaintID
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
////
////    static func gotoHome(delegate: UIViewController){
////        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
////        UIWindow.key.rootViewController = vc
////        UIWindow.key.makeKeyAndVisible()
////    }
////    
////    static func gotoNewsDetailVC(delegate: UIViewController, type: NewsType, index: IndexPath? = nil, newsID: Int? = nil, opinionID: Int? = nil){
////        let vc = UIStoryboard(name: Storyboard.news.rawValue, bundle: nil).instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
////        vc.newsType = type
////        vc.index = index
////        vc.newsDetailID = newsID
////        vc.opinionDetailID = opinionID
////        vc.modalPresentationStyle = .fullScreen
////        delegate.navigationController?.pushViewController(vc, animated: true)
////    }
//    
//    static func gotoAddComplaintScreen(delegate: UIViewController, addComplaintType: AddComplaintType){
//        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddTenantViewController") as! AddTenantViewController
//        vc.addType = addComplaintType
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoAddProperty(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddPropertyViewController") as! AddPropertyViewController
//        vc.delegate = delegate as? any AddPropertyDelegate
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
////    static func gotoFlatasHomeVC(delegate: UIViewController){
////        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SelfPropertyDetailViewController") as! SelfPropertyDetailViewController
////        vc.modalPresentationStyle = .fullScreen
////        vc.hidesBottomBarWhenPushed = false
////        delegate.navigationController?.pushViewController(vc, animated: true)
////    }
//    
//    static func gotoAddFlat(delegate: UIViewController, propertyID: Int){
//        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddFlatViewController") as! AddFlatViewController
//        vc.propertyID = propertyID
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        delegate.present(vc, animated: true)
//    }
//    
//    static func gotoAddBranch(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddBranchViewController") as! AddBranchViewController
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        delegate.present(vc, animated: true)
//    }
//    
//    static func gotoCompanyPropertyDetail(delegate: UIViewController, property: PropertiesRow){
//        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyPropertyDetailViewController") as! CompanyPropertyDetailViewController
//        vc.property = property
//        vc.modalPresentationStyle = .fullScreen
//        vc.hidesBottomBarWhenPushed = false
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoDatePicker(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "DateViewController") as! DateViewController
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        vc.delegate = delegate as? any DateProtocol
//        delegate.present(vc, animated: true)
//    }
//    
//    static func gotoCompanyDetail(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyDetailViewController") as! CompanyDetailViewController
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    static func gotoPhotoViewer(delegate: UIViewController, photos: [ComplainImage]? = nil,  propertyImages: [PropertyImage]? = nil, addComplaintPhoto: [UIImage]? = nil, position: IndexPath){
//        let vc = UIStoryboard(name: Storyboard.common.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PhotoViewerViewController") as! PhotoViewerViewController
//        vc.photos = photos
//        vc.position = position
//        vc.propertyImages = propertyImages
//        vc.addComplaintPhoto = addComplaintPhoto
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: false)
//    }
//    
    static func gotoOtpScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        delegate.present(vc, animated: true)
    }
    
//    static func logout(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        nav.hidesBottomBarWhenPushed = true
//        delegate.present(nav, animated: false)
//    }
//    
//    static func gotoProfile(delegate: UIViewController, userType: UserType){
//        let vc = UIStoryboard(name: Storyboard.common.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//        vc.userType = userType
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        delegate.present(nav, animated: true)
//    }
//    
//    static func changeLanguage(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
//        let nav = UINavigationController(rootViewController: vc)
//        UIApplication.shared.windows.first?.rootViewController = nav
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
//    
//    static func tenantLanguageChange(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantHomeViewController") as! TenantHomeViewController
//        let nav = UINavigationController(rootViewController: vc)
//        UIApplication.shared.windows.first?.rootViewController = nav
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
//    
//    static func workerLanguageChange(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkersHomeViewController") as! WorkersHomeViewController
//        let nav = UINavigationController(rootViewController: vc)
//        UIApplication.shared.windows.first?.rootViewController = nav
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
    
//    static func companyLanguageChange(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
//        let nav = UINavigationController(rootViewController: vc)
//        UIApplication.shared.windows.first?.rootViewController = nav
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
}
