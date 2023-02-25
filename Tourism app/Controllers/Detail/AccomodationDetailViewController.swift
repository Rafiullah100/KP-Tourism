//
//  AccomodationDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/8/22.
//

import UIKit
import SDWebImage
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import MapboxMaps
import CoreLocation

class AccomodationDetailViewController: BaseViewController {
  
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var parkingLabel: UILabel!
    @IBOutlet weak var bathLabel: UILabel!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dropDownImageView: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    var accomodationDetail: Accomodation?
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .backWithTitle
        viewControllerTitle = "\(accomodationDetail?.title ?? "") | Accomodation"
        detailView.isHidden = true
        
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (accomodationDetail?.thumbnailImage ?? "")))
        nameLabel.text = "\(accomodationDetail?.title ?? "")"
        locationLabel.text = "\(accomodationDetail?.locationTitle ?? "")"
        textView.text = "\(accomodationDetail?.description ?? "")"
        familyLabel.text = accomodationDetail?.family == true ? "Family" : "Adult"
        addressLabel.text = "\(accomodationDetail?.locationTitle ?? "")"
//        ratingLabel.text = "\(accomodationDetail?.locationTitle ?? "")"
        priceLabel.text = "\(accomodationDetail?.priceFrom ?? 0) PER NIGHT"
        bedLabel.text = "\(accomodationDetail?.noRoom ?? 0) Bed"
        parkingLabel.text = accomodationDetail?.parking == true ? "Avialable" : "No Parking"
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
    
    @IBAction func showDetailBtn(_ sender: Any) {
        if detailView.isHidden == true {
            detailView.isHidden = false
            dropDownImageView.image = UIImage(named: "collapse")
        }
        else{
            detailView.isHidden = true
            dropDownImageView.image = UIImage(named: "expand")
        }
    }
    @IBAction func likeBtnAction(_ sender: Any) {
    }
    
    @IBAction func directionBtnAction(_ sender: Any) {
        guard let originCoordinate = originCoordinate, let latitude: Double = Double(accomodationDetail?.latitude ?? ""), let longitude: Double = Double(accomodationDetail?.longitude ?? "") else { return  }
        let origin = Waypoint(coordinate: originCoordinate, name: "")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), name: "")
        
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        Directions.shared.calculate(routeOptions) { [weak self] (session, result) in
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

extension AccomodationDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}
