//
//  ChooseLocationViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/1/24.
//

import UIKit
import MapKit
class ChooseLocationViewController: UIViewController {
    
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var selectLocationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var chooseMapLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        backIcon.image = UIImage(named: Helper.shared.isRTL() ? "Right-arrow" : "ar-Right-arrow")
        chooseMapLabel.text = LocalizationKeys.chooseOnMap.rawValue.localizeString()
        textField.textAlignment = Helper.shared.isRTL() ? .right : .left
        textField.placeholder = LocalizationKeys.locationPlaceholder.rawValue.localizeString()
        confirmButton.setTitle(LocalizationKeys.confirmLocation.rawValue.localizeString(), for: .normal)
        
        let initialLocation = CLLocation(latitude: 24.7136, longitude: 46.6753)
        centerMapOnLocation(location: initialLocation)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation.coordinate
        annotation.title = "Riyadh"
        mapView.addAnnotation(annotation)
    }

    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 500 // 1 km
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
