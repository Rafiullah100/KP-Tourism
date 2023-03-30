//
//  GettingHereViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
//import GoogleMaps
import SwiftGifOrigin
import MapboxMaps
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import CoreLocation
import SVProgressHUD

class GettingHereViewController: BaseViewController {
    
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var directionbutton: UIButton!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    
    @IBOutlet weak var travelTypeLabel: UILabel!
    var locationCategory: LocationCategory?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var archeology: Archeology?

    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()

    
    var travelVC: TravelViewController {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "TravelViewController") as! TravelViewController
    }
    var navigationVC: GettingHereMapViewController {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "GettingHereMapViewController") as! GettingHereMapViewController
    }
    
    var travel: Travel?
    var gettingHere: GettingHereModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        travel = .textual
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(route: .fetchGettingHere, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0], model: GettingHereModel.self)
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
            fetch(route: .fetchGettingHere, method: .post, parameters: ["district_id": attractionDistrict?.id ?? 0], model: GettingHereModel.self)
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.image_url ?? "")))
            fetch(route: .fetchGettingHere, method: .post, parameters: ["district_id": archeology?.id ?? 0], model: GettingHereModel.self)
        }
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
    
    override func show(_ vc: UIViewController, sender: Any?) {
        switch travel {
        case .textual:
            listImageView.image = UIImage(named: "grid-green")
            mapImageView.image = UIImage(named: "map-white")
            directionbutton.isHidden = true
            let vc: TravelViewController = UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "TravelViewController") as! TravelViewController
            vc.gettingArray = gettingHere?.gettingHeres
            add(vc, in: containerView)
        case .navigation:
            listImageView.image = UIImage(named: "grid-white")
            mapImageView.image = UIImage(named: "map-green")
            directionbutton.isHidden = false
            let vc: GettingHereMapViewController = UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "GettingHereMapViewController") as! GettingHereMapViewController
            vc.gettingArray = gettingHere?.gettingHeres
            add(vc, in: containerView)
        default:
            break
        }
    }

//    }
    
    @IBAction func directionBtnAction(_ sender: Any) {
        showRoute()
    }
    
    private func showRoute(){
        guard let originCoordinate = originCoordinate, let latitude: Double = Double(gettingHere?.gettingHeres[0].districts.latitude ?? ""), let longitude: Double = Double(gettingHere?.gettingHeres[0].districts.longitude ?? "") else { return  }
        let origin = Waypoint(coordinate: originCoordinate, name: "")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), name: "")
        
        // Set options
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        
        // Request a route using MapboxDirections.swift
        SVProgressHUD.show(withStatus: "Please wait...")
        Directions(credentials: Credentials(accessToken: Constants.mapboxPublicKey)).calculate(routeOptions) { [weak self] (session, result) in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription, maskType: .none)
            case .success(let response):
                guard let self = self else { return }
                // Pass the first generated route to the the NavigationViewController
                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func textualButtonAction(_ sender: Any) {
        travel = .textual
        show(travelVC, sender: self)
    }
    
    @IBAction func mapBtnAction(_ sender: Any) {
        travel = .navigation
        show(navigationVC, sender: self)
    }

    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let gettingHere):
                DispatchQueue.main.async {
                    self.gettingHere = gettingHere as? GettingHereModel
                    self.show(self.travelVC, sender: self)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension GettingHereViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}
