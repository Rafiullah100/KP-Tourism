//
//  POIMapViewController.swift
//  Tourism app
//
//  Created by Rafi on 07/11/2022.
//

import UIKit
import Mapbox
import CoreLocation

class POIMapViewController: BaseViewController {
        
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var seacrhBgView: UIView!
    var locationCategory: LocationCategory?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var POISubCatories: POISubCatoriesModel?
    var archeology: Archeology?
    var mapView = MGLMapView()

    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        DispatchQueue.global().async {
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
        updateUI()
        loadMap()
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
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
        }
    }

    
    func loadMap() {
        if archeology != nil{
            guard let latitude = Double(archeology?.attractions.latitude ?? ""), let longitude = Double(archeology?.attractions.longitude ?? "") else {
                return
            }
            mapView = Helper.shared.showMap(view: mapViewContainer, latitude: latitude, longitude: longitude)
        }
        else if exploreDistrict != nil{
            guard let latitude = Double(exploreDistrict?.latitude ?? ""), let longitude = Double(exploreDistrict?.longitude ?? "") else {
                return
            }
            mapView = Helper.shared.showMap(view: mapViewContainer, latitude: latitude, longitude: longitude)
        }
        mapViewContainer.addSubview(mapView)
        mapView.delegate = self

        POISubCatories?.pois.rows.forEach({ point in
            guard let lat = Double(point.latitude ?? ""), let lon = Double(point.longitude ?? "")  else { return }
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            mapView.addAnnotation(point)
        })
    }
    
    @IBAction func listBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}

extension POIMapViewController: MGLMapViewDelegate{
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        POISubCatories?.pois.rows.forEach({ poi in
            guard let lat = Double(poi.latitude ?? ""), let lon = Double(poi.longitude ?? "")  else { return }
            let point = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), title: poi.title, subtitle: poi.locationTitle , image: UIImage(named: "dummy") ?? UIImage())
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
        print(annotation.coordinate.latitude, annotation.coordinate.longitude)
        getDirection(originCoordinate: originCoordinate, destinationCoordinate: CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
    }
}

extension POIMapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}
