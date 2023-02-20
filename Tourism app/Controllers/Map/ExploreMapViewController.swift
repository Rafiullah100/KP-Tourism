//
//  ExploreMapViewController.swift
//  Tourism app
//
//  Created by Rafi on 01/11/2022.
//

import UIKit
import MapboxMaps

class ExploreMapViewController: UIViewController {

    var exploreDistrict: [ExploreDistrict]?
    var attractionDistrict: [AttractionsDistrict]?
    var eventDistrict: [EventListModel]?

    var mapView: MapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
    }
    
    private func loadMap(){
        let myResourceOptions = ResourceOptions(accessToken: Constants.mapboxSecretKey)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.delegate = self

        mapView.location.delegate = self
        mapView.location.options.activityType = .other
        mapView.location.options.puckType = .puck2D()
        mapView.location.locationProvider.startUpdatingLocation()
        mapView.mapboxMap.onNext(event: .mapLoaded) { [self]_ in
            self.locationUpdate(newLocation: mapView.location.latestLocation!)
        }
        self.view.addSubview(mapView)
        print(exploreDistrict?.count ?? 0)
        //explore
        exploreDistrict?.forEach({ district in
            guard let lat = Double(district.latitude), let lon = Double(district.longitude)  else { return }
            var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2DMake(lat, lon))
            pointAnnotation.image = .init(image: UIImage(named: "marker") ?? UIImage() , name: "marker")
            pointAnnotation.iconAnchor = .bottom
            let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
            pointAnnotationManager.annotations = [pointAnnotation]
        })
        
        //attractions
        attractionDistrict?.forEach({ district in
            guard let lat = Double(district.latitude ?? ""), let lon = Double(district.longitude ?? "")  else { return }
            var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2DMake(lat, lon))
            pointAnnotation.image = .init(image: UIImage(named: "marker") ?? UIImage(), name: "marker")
            pointAnnotation.iconAnchor = .bottom
            let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
            pointAnnotationManager.annotations = [pointAnnotation]
        })
        
        //events
        eventDistrict?.forEach({ district in
            guard let lat = Double(district.latitude ?? ""), let lon = Double(district.longitude ?? "")  else { return }
            var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2DMake(lat, lon))
            pointAnnotation.image = .init(image: UIImage(named: "marker") ?? UIImage(), name: "marker")
            pointAnnotation.iconAnchor = .bottom
            let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
            pointAnnotationManager.annotations = [pointAnnotation]
        })
    }
}

extension ExploreMapViewController: LocationPermissionsDelegate, LocationConsumer {
    
    func locationUpdate(newLocation: Location) {
        mapView.camera.fly(to: CameraOptions(center: newLocation.coordinate, zoom: 7.0), duration: 2.0)
    }
}

//extension ExploreMapViewController: MGLMapViewDelegate{
//    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
//
//    }
//}

