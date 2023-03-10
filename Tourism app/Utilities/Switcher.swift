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
        delegate.present(vc, animated: true)
    }
    
    static func gotoAbout(delegate: UIViewController, exploreDetail: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, archeology: Archeology? = nil){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        vc.exploreDistrict = exploreDetail
        vc.attractionDistrict = attractionDistrict
        vc.archeology = archeology
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToDestination(delegate: UIViewController, type: LocationCategory, exploreDistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, archeologyDistrict: Archeology? = nil){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CommonViewController") as! CommonViewController
        vc.locationCategory = type
        vc.explore = exploreDistrict
        vc.attraction = attractionDistrict
        vc.archeology = archeologyDistrict
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAttractionDetail(delegate: UIViewController, attractionDistrict: AttractionsDistrict? = nil, archeologyDistrict: ArcheologyAttractions? = nil){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AttractionDetailViewController") as! AttractionDetailViewController
        vc.attractionDistrict = attractionDistrict
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToPOIServices(delegate: UIViewController, locationCategory: LocationCategory, exploredistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, poiCategoryId: Int){
        let vc = UIStoryboard(name: Storyboard.POI.rawValue, bundle: nil).instantiateViewController(withIdentifier: "POIServicesViewController") as! POIServicesViewController
        vc.locationCategory = locationCategory
        vc.exploreDistrict = exploredistrict
        vc.attractionDistrict = attractionDistrict
        vc.poiCategoriId = poiCategoryId
        print(poiCategoryId)
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToPOIMap(delegate: UIViewController, locationCategory: LocationCategory, exploreDistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, poiSubCategory: POISubCatoriesModel){
        let vc = UIStoryboard(name: Storyboard.POI.rawValue, bundle: nil).instantiateViewController(withIdentifier: "POIMapViewController") as! POIMapViewController
        vc.locationCategory = locationCategory
        vc.exploreDistrict = exploreDistrict
        vc.attractionDistrict = attractionDistrict
        vc.POISubCatories = poiSubCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToNavigation(delegate: UIViewController, locationCategory: LocationCategory){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "GettingHereMapViewController") as! GettingHereMapViewController
        vc.locationCategory = locationCategory
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToAttraction(delegate: UIViewController, locationCategory: LocationCategory, exploreDistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, archeology: Archeology? = nil){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AttractionViewController") as! AttractionViewController
        vc.locationCategory = locationCategory
        vc.exploreDistrict = exploreDistrict
        vc.attractionDistrict = attractionDistrict
        vc.archeology = archeology
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToGettingHere(delegate: UIViewController, locationCategory: LocationCategory, exploreDistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, archeology: Archeology? = nil){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "GettingHereViewController") as! GettingHereViewController
        vc.locationCategory = locationCategory
        vc.exploreDistrict = exploreDistrict
        vc.attractionDistrict = attractionDistrict
        vc.archeology = archeology
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }

    static func goToPOI(delegate: UIViewController, locationCategory: LocationCategory, exploreDistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, archeology: Archeology? = nil){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PointOfInterestViewController") as! PointOfInterestViewController
        vc.locationCategory = locationCategory
        vc.exploreDistrict = exploreDistrict
        vc.attractionsDistrict = attractionDistrict
        vc.archeology = archeology
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToAccomodation(delegate: UIViewController, exploreDistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, archeology: Archeology? = nil){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AccomodationViewController") as! AccomodationViewController
        vc.exploreDistrict = exploreDistrict
        vc.attractionDistrict = attractionDistrict
        vc.archeology = archeology
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToEvents(delegate: UIViewController, exploreDistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, archeology: Archeology? = nil){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
        vc.exploreDistrict = exploreDistrict
        vc.attractionDistrict = attractionDistrict
        vc.archeology = archeology
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToItinrary(delegate: UIViewController, locationCategory: LocationCategory, exploreDistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, archeology: Archeology? = nil){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ItenrariesViewController") as! ItenrariesViewController
        vc.locationCategory = locationCategory
        vc.exploreDistrict = exploreDistrict
        vc.attractionDistrict = attractionDistrict
        vc.archeology = archeology
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToProducts(delegate: UIViewController, exploreDistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, archeology: Archeology? = nil){
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LocalProductsViewController") as! LocalProductsViewController
        vc.exploreDistrict = exploreDistrict
        vc.attractionDistrict = attractionDistrict
        vc.archeology = archeology
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
//    static func gotoGallery(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.gallery.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
    
    static func gotoGalleryDetail(delegate: UIViewController, galleryDetail: GalleryModel, mediaType: MediaType){
        let vc = UIStoryboard(name: Storyboard.gallery.rawValue, bundle: nil).instantiateViewController(withIdentifier: "GalleryDetailViewController") as! GalleryDetailViewController
        vc.galleryDetail = galleryDetail
        vc.mediaType = mediaType
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    static func gotoGallery(delegate: UIViewController, exploreDistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, mediaType: MediaType, archeology: Archeology? = nil){
        let vc = UIStoryboard(name: Storyboard.gallery.rawValue, bundle: nil).instantiateViewController(withIdentifier: "GalleryDetailViewController") as! GalleryDetailViewController
        vc.exploreDistrict = exploreDistrict
        vc.attractionDistrict = attractionDistrict
        vc.archeology = archeology
        vc.mediaType = mediaType
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
    
    static func gotoEventDetail(delegate: UIViewController, event: EventListModel){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
        vc.eventDetail = event
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoBlogDetail(delegate: UIViewController, blogDetail: Blog){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "BlogDetailViewController") as! BlogDetailViewController
        vc.blogDetail = blogDetail
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoProductDetail(delegate: UIViewController, product: LocalProduct){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        vc.productDetail = product
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAccomodationDetail(delegate: UIViewController, AccomodationDetail: Accomodation){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AccomodationDetailViewController") as! AccomodationDetailViewController
        vc.accomodationDetail = AccomodationDetail
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAdventureDetail(delegate: UIViewController, adventure: Adventure){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AdventureDetailViewController") as! AdventureDetailViewController
        vc.adventureDetail = adventure
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoPackageDetail(delegate: UIViewController, tourDetail: TourPackage){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PackageDetailViewController") as! PackageDetailViewController
        vc.tourDetail = tourDetail
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
    
    static func goToWishlistVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WishlistViewController") as! WishlistViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToSettingVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToSecurityVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SecurityViewController") as! SecurityViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToSellerVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SellerViewController") as! SellerViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToPersonalInfoVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PersonalInfoViewController") as! PersonalInfoViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToChatVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoVisitKP(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.visitkp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "VisitKPViewController") as! VisitKPViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoVisitExpVC(delegate: UIViewController, geoTypeId: String){
        let vc = UIStoryboard(name: Storyboard.visitkp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ExperienceViewController") as! ExperienceViewController
        vc.geoTypeId = geoTypeId
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoTourDestinationVC(delegate: UIViewController, experienceID: Int, geoTypeID: String){
        let vc = UIStoryboard(name: Storyboard.visitkp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TourDestinationViewController") as! TourDestinationViewController
        vc.geoTypeId = geoTypeID
        vc.experienceId = experienceID
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoTourAccomodationVC(delegate: UIViewController, districtID: Int){
        let vc = UIStoryboard(name: Storyboard.visitkp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TourAccomodationViewController") as! TourAccomodationViewController
        vc.districtID = districtID
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoTourpdfVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.visitkp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TourPdfViewController") as! TourPdfViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoTourInformationVC(delegate: UIViewController, districtID: Int){
        let vc = UIStoryboard(name: Storyboard.visitkp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "InformationViewController") as! InformationViewController
        vc.districtID = districtID
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func presentLoginVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .automatic
        delegate.present(vc, animated: true)
    }
    static func gotoViewerVC(delegate: UIViewController, galleryDetail: GalleryModel? = nil, position: IndexPath, poiGallery: [PoiGallery]? = nil, type: galleryType){
        let vc = UIStoryboard(name: Storyboard.gallery.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ViewerViewController") as! ViewerViewController
        vc.galleryDetail = galleryDetail
        vc.position = position
        vc.poiGallery = poiGallery
        vc.galleryType = type
        vc.modalPresentationStyle = .automatic
        delegate.present(vc, animated: true)
    }
    
    static func goToItinraryDetail(delegate: UIViewController, itinraryDetail: ItinraryRow){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ItinraryDetailViewController") as! ItinraryDetailViewController
        vc.itinraryDetail = itinraryDetail
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToPOIDetailVC(delegate: UIViewController, poiDetail: POISubCatoryModel /*locationCategory: LocationCategory, exploredistrict: ExploreDistrict? = nil, attractionDistrict: AttractionsDistrict? = nil, poiCategoryId: Int*/){
        let vc = UIStoryboard(name: Storyboard.POI.rawValue, bundle: nil).instantiateViewController(withIdentifier: "POIDetailViewController") as! POIDetailViewController
        vc.poiDetail = poiDetail
//        vc.locationCategory = locationCategory
//        vc.exploreDistrict = exploredistrict
//        vc.attractionDistrict = attractionDistrict
//        vc.poiCategoriId = poiCategoryId
//        print(poiCategoryId)
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToWizardVC(delegate: UIViewController, visitDetail: VisitKPRow){
        let vc = UIStoryboard(name: Storyboard.visitkp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WizardViewController") as! WizardViewController
        vc.visitDetail = visitDetail
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoPostVC(delegate: UIViewController, postType: PostType, feed: FeedModel? = nil){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.postType = postType
        vc.feed = feed
        delegate.present(vc, animated: true, completion: nil)
    }
    
    static func gotoPDFViewer(delegate: UIViewController, url: String){
        let vc = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ViewPDFViewController") as! ViewPDFViewController
        vc.urlString = url
        vc.modalPresentationStyle = .automatic
        delegate.present(vc, animated: true, completion: nil)
    }
    
//    static func presentBottomSheet(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.sheet.rawValue, bundle: nil).instantiateViewController(withIdentifier: "BottomSheetViewController") as! BottomSheetViewController
//        let nav = UINavigationController(rootViewController: vc)
//        if let sheet = nav.sheetPresentationController {
//            if #available(iOS 16.0, *) {
//                sheet.detents = [.custom(resolver: { context in
//                    return 250.0
//                })]
//            } else {
//                sheet.detents = [.medium()]
//            }
//        }
//        delegate.present(nav, animated: true, completion: nil)
//    }
}

