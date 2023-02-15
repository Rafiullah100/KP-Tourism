//
//  NavigationViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 11/23/22.
//

import UIKit
import GoogleMaps

class NavigationViewController: BaseViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapViewContainer: UIView!
    var locationManager: CLLocationManager!
    var locationCategory: LocationCategory?

    var gettingHere: GettingHereModel?

    
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
//        setupMap()
        
        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 7.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
//        mapView.delegate = self
        mapViewContainer.addSubview(mapView)
        
        let marker = GMSMarker()
        guard let latitude = Double(gettingHere?.gettingHeres[0].districts.latitude ?? "" ), let longitude = Double(gettingHere?.gettingHeres[0].districts.longitude ?? "" ) else { return }
        
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.iconView = UIImageView(image: UIImage(named: "marker")!.withRenderingMode(.alwaysOriginal))
//        marker.userData = district.id
//        marker.title = district.title
//        marker.snippet = district.title
        marker.map = mapView
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0] as CLLocation
//        setupMap(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
//        manager.stopUpdatingLocation()
//    }
//
//    private func setupMap(lat: Double? = nil, lon: Double? = nil){
//        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 12.0)
//        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//        mapView.settings.compassButton = true
//        mapViewContainer.addSubview(mapView)
//    }
}
