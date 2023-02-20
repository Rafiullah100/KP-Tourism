//
//  POIMapViewController.swift
//  Tourism app
//
//  Created by Rafi on 07/11/2022.
//

import UIKit
import MapboxMaps
class POIMapViewController: BaseViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var seacrhBgView: UIView!
    var locationCategory: LocationCategory?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var POISubCatories: POISubCatoriesModel?

    internal var mapView: MapView!

    
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
        POISubCatories?.pois.rows.forEach({ point in
            guard let lat = Double(point.latitude), let lon = Double(point.longitude)  else { return }
            var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2DMake(lat, lon))
            pointAnnotation.image = .init(image: UIImage(named: "marker")!, name: "marker")
            pointAnnotation.iconAnchor = .bottom
            let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
            pointAnnotationManager.annotations = [pointAnnotation]
        })
    }
    
//    func updateUI() {
//        if exploreDistrict != nil {
//            thumbnailTopLabel.text = exploreDistrict?.title
//            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
//        }
//        else if attractionDistrict != nil{
//            thumbnailTopLabel.text = attractionDistrict?.title
//            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0] as CLLocation
//        setupMap(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
//        manager.stopUpdatingLocation()
//    }
//
//    private func setupMap(lat: Double, lon: Double){
////        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 12.0)
//        let camera = GMSCameraPosition.camera(withLatitude: 31.2227, longitude: 71.4258, zoom: 12.0)
//
//        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//        mapViewContainer.addSubview(mapView)
//        mapViewContainer.bringSubviewToFront(seacrhBgView)
//
//        POISubCatories?.pois.rows.forEach({ poi in
//            let marker = GMSMarker()
//            guard let latitude: Double = Double(poi.latitude ?? ""), let longitude: Double = Double(poi.longitude ?? "") else { return }
//            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            marker.iconView = UIImageView(image: UIImage(named: "marker")!.withRenderingMode(.alwaysOriginal))
//            marker.userData = poi.id
//            marker.map = mapView
//        })
//    }
    
    
    @IBAction func listBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
//        guard let district = district else { return }
//        Switcher.goToPOIServices(delegate: self, locationCategory: locationCategory!, district: district)
    }
}

extension POIMapViewController: LocationPermissionsDelegate, LocationConsumer {
    func locationUpdate(newLocation: Location) {
        mapView.camera.fly(to: CameraOptions(center: newLocation.coordinate, zoom: 7.0), duration: 2.0)
    }
}
