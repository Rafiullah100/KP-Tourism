//
//  AttractionDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/16/23.
//

import UIKit
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import MapboxMaps
import SVProgressHUD
class AttractionDetailViewController: BaseViewController {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    
    var attractionDistrict: AttractionsDistrict?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        updateUI()
    }

    func updateUI() {
        thumbnailTopLabel.text = attractionDistrict?.title
        thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
        nameLabel.text = attractionDistrict?.title
        textView.text = attractionDistrict?.description.stripOutHtml()
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
    
    @IBAction func directionBtnAction(_ sender: Any) {
        guard let originCoordinate = originCoordinate, let lat: Double = Double(attractionDistrict?.latitude ?? ""), let lon: Double = Double(attractionDistrict?.longitude ?? "") else { return  }
        let origin = Waypoint(coordinate: originCoordinate, name: "")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), name: "")
        
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        SVProgressHUD.show(withStatus: "Please wait...")
        Directions(credentials: Credentials(accessToken: Constants.mapboxPublicKey)).calculate(routeOptions) { [weak self] (session, result) in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                guard let self = self else { return }
                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
}

extension AttractionDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}

