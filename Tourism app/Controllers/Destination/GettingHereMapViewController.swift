//
//  NavigationViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 11/23/22.
//

import UIKit
//import GoogleMaps
import MapboxMaps


protocol DirectionDelegate {
    func showDirection(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D)
}

class GettingHereMapViewController: BaseViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapViewContainer: UIView!
    var locationManager: CLLocationManager!
    var locationCategory: LocationCategory?
    
    var gettingArray: [GettingHere]?
    internal var mapView: MapView!
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    
    var delegate: DirectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        
        let myResourceOptions = ResourceOptions(accessToken: Constants.mapboxSecretKey)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
        mapView = MapView(frame: mapViewContainer.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.location.delegate = self
        
        mapView.location.options.activityType = .other
        mapView.location.options.puckType = .puck2D()
        mapView.location.locationProvider.startUpdatingLocation()
        mapView.mapboxMap.onNext(event: .mapLoaded) { [self]_ in
            self.locationUpdate(newLocation: mapView.location.latestLocation!)
        }
        self.mapViewContainer.addSubview(mapView)
        
        //show marker
        gettingArray?.forEach({ point in
            guard let lat = Double(point.districts.latitude), let lon = Double(point.districts.longitude)  else { return }
            destinationCoordinate = CLLocationCoordinate2DMake(lat, lon)
            var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2DMake(lat, lon))
            pointAnnotation.image = .init(image: UIImage(named: "marker")!, name: "marker")
            pointAnnotation.iconAnchor = .bottom
            let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
            pointAnnotationManager.annotations = [pointAnnotation]
        })
    }
    
    @IBAction func naviigationButtonAction(_ sender: Any) {
        //        Switcher.goToNavigation(delegate: self, locationCategory: locationCategory!)
    }
}


extension GettingHereMapViewController: LocationPermissionsDelegate, LocationConsumer {
    func locationUpdate(newLocation: Location) {
        originCoordinate = CLLocationCoordinate2D(latitude: newLocation.location.coordinate.latitude, longitude: newLocation.location.coordinate.longitude)
        guard let originCoordinate = originCoordinate, let destinationCoordinate = destinationCoordinate else { return }
        delegate?.showDirection(origin: originCoordinate, destination: destinationCoordinate)
        mapView.camera.fly(to: CameraOptions(center: newLocation.coordinate, zoom: 7.0), duration: 2.0)
    }
}
