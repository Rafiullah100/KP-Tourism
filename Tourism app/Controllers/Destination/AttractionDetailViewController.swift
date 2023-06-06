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
        thumbnailBottomLabel.text = attractionDistrict?.locationTitle
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
        guard let originCoordinate = originCoordinate, let lat: Double = Double(attractionDistrict?.latitude ?? ""), let lon: Double = Double(attractionDistrict?.longitude ?? "") else {
            self.view.makeToast(Constants.noCoordinate)
            return  }
        getDirection(originCoordinate: originCoordinate, destinationCoordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
    }
}

extension AttractionDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}

