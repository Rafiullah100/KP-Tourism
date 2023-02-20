//
//  GettingHereViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import GoogleMaps
import SwiftGifOrigin
import MapboxMaps
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import CoreLocation


class GettingHereViewController: BaseViewController, CLLocationManagerDelegate {
    enum Travel {
        case textual
        case navigation
    }
    
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var directionbutton: UIButton!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    
    @IBOutlet weak var travelTypeLabel: UILabel!
    var locationCategory: LocationCategory?
    var locationManager: CLLocationManager!
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    
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
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
            fetch(route: .fetchGettingHere, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0], model: GettingHereModel.self)
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
            fetch(route: .fetchGettingHere, method: .post, parameters: ["district_id": attractionDistrict?.id ?? 0], model: GettingHereModel.self)
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
            vc.delegate = self
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
        let origin = Waypoint(coordinate: originCoordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), name: "")
        let destination = Waypoint(coordinate: destinationCoordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), name: "")
        
        // Set options
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        
        // Request a route using MapboxDirections.swift
        Directions.shared.calculate(routeOptions) { [weak self] (session, result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
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


extension GettingHereViewController: DirectionDelegate{
    func showDirection(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        self.originCoordinate = origin
        self.destinationCoordinate = destination
    }
}
