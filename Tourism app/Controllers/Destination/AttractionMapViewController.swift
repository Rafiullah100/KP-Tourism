//
//  AttractionMapViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/8/23.
//

import UIKit
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import CoreLocation
import Mapbox
import SVProgressHUD

class AttractionMapViewController: UIViewController {
    @IBOutlet weak var mapViewContainer: UIView!
    var attractionsArray: [AttractionsDistrict]?

    var mapView = MGLMapView()
    //    @IBOutlet weak var markerView: MarkerView!
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    private func loadMap(){
        guard attractionsArray?.count ?? 0 > 0 else { return }
        guard let latitude = Double(attractionsArray?.first?.latitude ?? ""), let longitude = Double(attractionsArray?.first?.longitude ?? "")  else { return }
        print(latitude, longitude)
        mapView = Helper.shared.showMap(view: view, latitude: latitude, longitude: longitude)
        view.addSubview(mapView)
        mapView.delegate = self
    }
}

extension AttractionMapViewController: MGLMapViewDelegate{
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        attractionsArray?.forEach({ district in
            guard let lat = Double(district.latitude ?? ""), let lon = Double(district.longitude ?? "")  else { return }
            let point = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), title: district.title ?? "", subtitle: district.locationTitle ?? "", image: UIImage(named: "dummy") ?? UIImage())
            mapView.addAnnotation(point)
        })
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        guard let originCoordinate = originCoordinate else {
            self.view.makeToast(Constants.noCoordinate)
            return  }
        getDirection(originCoordinate: originCoordinate, destinationCoordinate: CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
    }
}

extension AttractionMapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}
