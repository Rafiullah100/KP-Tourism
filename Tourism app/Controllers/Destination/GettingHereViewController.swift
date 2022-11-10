//
//  GettingHereViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import GoogleMaps
import SwiftGifOrigin

class GettingHereViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var textualView: UIStackView!
    @IBOutlet weak var mapContainerView: UIView!
    
    @IBOutlet weak var textualButton: UIButton!
    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var carImage: UIImageView!
    enum Travel {
        case textual
        case navigation
    }
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapTextual(travel: .textual)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        setupMap(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
        manager.stopUpdatingLocation()
    }
    
    private func setupMap(lat: Double, lon: Double){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapContainerView.addSubview(mapView)
    }
    
    @IBAction func textualButtonAction(_ sender: Any) {
        mapTextual(travel: .textual)
    }
    
    @IBAction func naviigationButtonAction(_ sender: Any) {
        mapTextual(travel: .navigation)
    }
    
    private func mapTextual(travel: Travel){
        switch travel {
        case .textual:
            textualButton.setTitleColor(.black, for: .normal)
            navigationButton.setTitleColor(Constants.blackishGrayColor, for: .normal)
            textualButton.backgroundColor = Constants.darkGrayColor
            navigationButton.backgroundColor = Constants.lightGrayColor
            textualView.isHidden = false
            mapContainerView.isHidden = true
        case .navigation:
            textualButton.setTitleColor(Constants.blackishGrayColor, for: .normal)
            navigationButton.setTitleColor(.black, for: .normal)
            textualButton.backgroundColor = Constants.lightGrayColor
            navigationButton.backgroundColor = Constants.darkGrayColor
            textualView.isHidden = true
            mapContainerView.isHidden = false
        }
    }
}
