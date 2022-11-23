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

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
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
        mapViewContainer.addSubview(mapView)
    }
    @IBAction func navigationBtnAction(_ sender: Any) {
    }
    
}
