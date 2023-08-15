//
//  PlannerDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 8/15/23.
//

import UIKit
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import CoreLocation
import Mapbox
class PlannerDetailTableViewCell: UITableViewCell {
//    var experienceID: Int?
    
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("selected")
    }
}

class PlannerDetailViewController: UIViewController {
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var navigationLabel: UILabel!
    
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var gradientView: UIView!
    var mapView = MGLMapView()
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    var tourPlan: UserTourPlanModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func loadMap(){
        mapView = Helper.shared.showMap(view: view, latitude: originCoordinate?.latitude, longitude: originCoordinate?.longitude)
        mapView.zoomLevel = 7
        mapContainerView.addSubview(mapView)
        mapView.delegate = self
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

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PlannerDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlannerDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! PlannerDetailTableViewCell
        if indexPath.row == 0 {
            cell.leftLabel.text = "Visit KP:"
            cell.rightLabel.text = tourPlan?.geoType
        }
        else if indexPath.row == 1 {
            cell.leftLabel.text = "Destination:"
            cell.rightLabel.text = tourPlan?.district?.title
        }
        else if indexPath.row == 2 {
            cell.leftLabel.text = "Destination:"
            cell.rightLabel.text = tourPlan?.travelerInfo
        }
        else if indexPath.row == 3 {
            cell.leftLabel.text = "Attraction:"
            cell.rightLabel.text = tourPlan?.attraction?.title
        }
        else if indexPath.row == 4 {
            cell.leftLabel.text = "Accomodation:"
            cell.rightLabel.text = tourPlan?.bookStay?.title
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40.0
//    }
}

extension PlannerDetailViewController: MGLMapViewDelegate{
//    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
//        exploreDistrict?.forEach({ district in
//            guard let lat = Double(district.latitude ?? ""), let lon = Double(district.longitude ?? "")  else { return }
//            let point = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), title: district.title ?? "", subtitle: district.locationTitle ?? "", image: UIImage(named: "dummy") ?? UIImage())
//            //            point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//            mapView.addAnnotation(point)
//        })
//    }
    
    
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
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
            let routeCoordinates: [CLLocationCoordinate2D] = [
                CLLocationCoordinate2D(latitude: originCoordinate?.latitude ?? 0.0, longitude: originCoordinate?.longitude ?? 0.0),
                CLLocationCoordinate2D(latitude: 34.6138, longitude: 71.9283), // Example coordinates
                CLLocationCoordinate2D(latitude: 34.827769, longitude: 71.842309)  // Example coordinates
            ]
            let polyline = MGLPolylineFeature(coordinates: routeCoordinates, count: UInt(routeCoordinates.count))
            let source = MGLShapeSource(identifier: "route-source", shape: polyline, options: nil)
            style.addSource(source)
            let layer = MGLLineStyleLayer(identifier: "route-layer", source: source)
            layer.lineColor = NSExpression(forConstantValue: UIColor.blue)
            layer.lineWidth = NSExpression(forConstantValue: 3)
            style.addLayer(layer)
        }
}

extension PlannerDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        loadMap()
    }
}
