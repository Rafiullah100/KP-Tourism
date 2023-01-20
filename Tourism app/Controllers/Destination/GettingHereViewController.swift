//
//  GettingHereViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import GoogleMaps
import SwiftGifOrigin

class GettingHereViewController: BaseViewController, CLLocationManagerDelegate {
    enum Travel {
        case textual
        case navigation
    }
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    
    @IBOutlet weak var travelTypeLabel: UILabel!
    var locationCategory: LocationCategory?
    var locationManager: CLLocationManager!
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    
    
    var travelVC: TravelViewController {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "TravelViewController") as! TravelViewController
    }
    var navigationVC: NavigationViewController {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "NavigationViewController") as! NavigationViewController
    }
    
    var travel: Travel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        DispatchQueue.global().async {
//            if CLLocationManager.locationServicesEnabled() {
//                self.locationManager.startUpdatingLocation()
//            }
//        }
        updateUI()
        show(travelVC, sender: self)
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        add(vc, in: containerView)
    }
    
    func updateUI() {
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0] as CLLocation
//        setupMap(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
//        manager.stopUpdatingLocation()
//    }
//
//    private func setupMap(lat: Double, lon: Double){
//        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 12.0)
//        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//        mapView.settings.compassButton = true
////        mapContainerView.addSubview(mapView)
//    }
    
    @IBAction func textualButtonAction(_ sender: Any) {
        show(travelVC, sender: self)
    }
    
    @IBAction func mapBtnAction(_ sender: Any) {
        show(navigationVC, sender: self)
    }
    
    
    @IBAction func naviigationButtonAction(_ sender: Any) {
//        Switcher.goToNavigation(delegate: self, locationCategory: locationCategory!)
    }
}
