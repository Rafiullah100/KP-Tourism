//
//  NavigationViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 11/23/22.
//

import UIKit
//import GoogleMaps
import MapboxMaps
import Mapbox


class GettingHereMapViewController: BaseViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapViewContainer: UIView!
    var locationManager = CLLocationManager()
    var locationCategory: LocationCategory?
    
    var gettingArray: [GettingHere]?
    
    var mapView = MGLMapView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        loadMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global().async {
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
        
    }
    
    func loadMap() {
        let url = URL(string: "mapbox://styles/mapbox/streets-v12")
        let mapView = MGLMapView(frame: mapViewContainer.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: Constants.kpkCoordinates.lat, longitude: Constants.kpkCoordinates.long), zoomLevel: 7, animated: false)
        mapView.styleURL = MGLStyle.streetsStyleURL
        mapView.tintColor = .darkGray
        mapViewContainer.addSubview(mapView)
        
        gettingArray?.forEach({ point in
            guard let lat = Double(point.districts.latitude), let lon = Double(point.districts.longitude)  else { return }
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            mapView.addAnnotation(point)
        })
    }
    
    @IBAction func naviigationButtonAction(_ sender: Any) {
        //        Switcher.goToNavigation(delegate: self, locationCategory: locationCategory!)
    }
}

