//
//  ExploreMapViewController.swift
//  Tourism app
//
//  Created by Rafi on 01/11/2022.
//

import UIKit
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import CoreLocation
import Mapbox
import SVProgressHUD
class ExploreMapViewController: UIViewController {
    
    var exploreDistrict: [ExploreDistrict]?
    
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
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func loadMap(){
        let url = URL(string: "mapbox://styles/mapbox/streets-v12")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: Constants.kpkCoordinates.lat, longitude: Constants.kpkCoordinates.long), zoomLevel: 7, animated: false)
        mapView.styleURL = MGLStyle.streetsStyleURL
        mapView.tintColor = .darkGray
        view.addSubview(mapView)
        mapView.delegate = self
    }
    
}

extension ExploreMapViewController: MGLMapViewDelegate{
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        exploreDistrict?.forEach({ district in
            print(district.latitude, district.longitude)
            guard let lat = Double(district.latitude), let lon = Double(district.longitude)  else { return }
            let point = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), title: district.title, subtitle: district.locationTitle, image: UIImage(named: "dummy") ?? UIImage())
            //            point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            mapView.addAnnotation(point)
        })
    }
    
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }
    //
    //    private func mapView(_ mapView: MGLMapView, calloutViewFor annotation: CustomAnnotation) -> MGLCalloutView? {
    //        let title = annotation.title ?? nil
    //        let subtitle = annotation.subtitle ?? nil
    //        let image = UIImage(named: "dummy")!
    //        let customAnnotation = CustomAnnotation(coordinate: annotation.coordinate, title: title ?? "", subtitle: subtitle ?? "", image: image)
    //        mapView.setCenter(CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude), zoomLevel: 7, animated: false)
    //        return MarkerView(annotation: customAnnotation, annotationPoint: mapView.convert(annotation.coordinate, toPointTo: nil))
    //    }
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        guard let originCoordinate = originCoordinate else { return  }
        let origin = Waypoint(coordinate: originCoordinate, name: "")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude), name: "")
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        
        // Request a route using MapboxDirections.swift

        SVProgressHUD.show(withStatus: "Please wait...")
        Directions(credentials: Credentials(accessToken: Constants.mapboxPublicKey)).calculate(routeOptions) { [weak self] (session, result) in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                guard let self = self else { return }
                let viewController = NavigationViewController(for: IndexedRouteResponse(routeResponse: response, routeIndex: 0))
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
}

extension ExploreMapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}
