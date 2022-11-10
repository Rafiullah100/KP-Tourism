//
//  POIMapViewController.swift
//  Tourism app
//
//  Created by Rafi on 07/11/2022.
//

import UIKit
import GoogleMaps
class POIMapViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!

    
    @IBOutlet weak var seacrhBgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        view.addSubview(mapView)
        view.bringSubviewToFront(seacrhBgView)
    }
}
