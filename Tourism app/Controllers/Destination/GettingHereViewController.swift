//
//  GettingHereViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import GoogleMaps
import SwiftGifOrigin

class GettingHereViewController: BaseViewController, CLLocationManagerDelegate {
    enum Travel {
        case textual
        case navigation
    }
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    
    var locationCategory: LocationCategory?
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        mapTextual(travel: .textual)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
        }
        updateUI()
    }
    
    func updateUI() {
        switch locationCategory {
        case .district:
            thumbnailTopLabel.text = "Swat"
            thumbnailBottomLabel.text = "KP"
            thumbnail.image = UIImage(named: "Path 94")
        case .tourismSpot:
            thumbnailTopLabel.text = "Kalam"
            thumbnailBottomLabel.text = "Swat"
            thumbnail.image = UIImage(named: "iten")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        setupMap(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
        manager.stopUpdatingLocation()
    }
    
    private func setupMap(lat: Double, lon: Double){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
//        mapContainerView.addSubview(mapView)
    }
    
    @IBAction func textualButtonAction(_ sender: Any) {
        mapTextual(travel: .textual)
    }
    
    @IBAction func naviigationButtonAction(_ sender: Any) {
        Switcher.goToNavigation(delegate: self, locationCategory: locationCategory!)
    }
    
    private func mapTextual(travel: Travel){
//        switch travel {
//        case .textual:
//            textualButton.setTitleColor(.black, for: .normal)
//            navigationButton.setTitleColor(Constants.blackishGrayColor, for: .normal)
//            textualButton.backgroundColor = Constants.darkGrayColor
//            navigationButton.backgroundColor = Constants.lightGrayColor
//            textualView.isHidden = false
//            mapContainerView.isHidden = true
//        case .navigation:
//            textualButton.setTitleColor(Constants.blackishGrayColor, for: .normal)
//            navigationButton.setTitleColor(.black, for: .normal)
//            textualButton.backgroundColor = Constants.lightGrayColor
//            navigationButton.backgroundColor = Constants.darkGrayColor
//            textualView.isHidden = true
//            mapContainerView.isHidden = false
//        }
    }
}
