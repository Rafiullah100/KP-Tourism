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

class PlannerDetailViewController: BaseViewController {
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var navigationLabel: UILabel!
    
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    var mapView = MGLMapView()
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    var tourPlan: UserTourPlanModel?
    var isMapLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        dateLabel.text = "Created: \(Helper.shared.dateFormate(dateString: tourPlan?.createdAt ?? ""))"
    }
    
    @IBAction func deleteTourBtnAction(_ sender: Any) {
        deleteTourPlan(parameters: ["id": tourPlan?.id ?? 0])
    }
    
    func deleteTourPlan(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .deleteTourPlan, method: .post, showLoader: true, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let model):
                self.view.makeToast(model.message)
                if model.success == true{
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.tourPlan), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    private func loadMap(){
        mapView = Helper.shared.showMap(view: view, latitude: originCoordinate?.latitude, longitude: originCoordinate?.longitude)
        mapView.zoomLevel = 7
        mapView.showsUserLocation = true
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
}

extension PlannerDetailViewController: MGLMapViewDelegate{
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        guard let districtLat = Double(tourPlan?.district?.latitude ?? "0"), let districtlon = Double(tourPlan?.district?.longitude ?? "0"), let attractionLat = Double(tourPlan?.attraction?.latitude ?? "0"), let attractionlon = Double(tourPlan?.attraction?.longitude ?? "0"), let bookStaylat = Double(tourPlan?.bookStay?.latitude ?? "0"), let bookStaylon = Double(tourPlan?.bookStay?.longitude ?? "0")  else { return }
        let districtPoint = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: districtLat, longitude: districtlon), title: tourPlan?.district?.title ?? "", subtitle: tourPlan?.geoType ?? "", image: UIImage(named: "dummy") ?? UIImage())
        let attractionPoint = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: attractionLat, longitude: attractionlon), title: tourPlan?.attraction?.title ?? "", subtitle: tourPlan?.district?.title ?? "", image: UIImage(named: "dummy") ?? UIImage())
        let bookStayPoint = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: bookStaylat, longitude: bookStaylon), title: tourPlan?.bookStay?.title ?? "", subtitle: tourPlan?.attraction?.title ?? "", image: UIImage(named: "dummy") ?? UIImage())
        mapView.addAnnotation(districtPoint)
        mapView.addAnnotation(attractionPoint)
        mapView.addAnnotation(bookStayPoint)
        tourPlan?.attraction?.pois?.forEach({ attractionPoi in
            guard let lat = Double(attractionPoi.latitude ?? ""), let lon = Double(attractionPoi.longitude ?? "")  else { return }
            let point = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), title: attractionPoi.title ?? "", subtitle: attractionPoi.locationTitle ?? "", image: UIImage(named: "dummy") ?? UIImage())
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

extension PlannerDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        if isMapLoaded == false {
            loadMap()
            isMapLoaded = true
        }
    }
}
