//
//  GettingHereViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import GoogleMaps
import SwiftGifOrigin

class GettingHereViewController: UIViewController {
    @IBOutlet weak var textualView: UIStackView!
    @IBOutlet weak var mapContainerView: UIView!
    
    @IBOutlet weak var textualButton: UIButton!
    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var carImage: UIImageView!
    enum Travel {
        case textual
        case navigation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        mapTextual(travel: .textual)
    }

    private func setupMap(){
        let camera = GMSCameraPosition.camera(withLatitude: 35.2227, longitude: 72.4258, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapContainerView.addSubview(mapView)
    }
    
    @IBAction func textualButtonAction(_ sender: Any) {
        mapTextual(travel: .textual)
    }
    
    @IBAction func naviigationButtonAction(_ sender: Any) {
        mapTextual(travel: .navigation)
    }
    
    private func mapTextual(travel: Travel){
        switch travel {
        case .textual:
            textualButton.setTitleColor(.black, for: .normal)
            navigationButton.setTitleColor(Constants.blackishGrayColor, for: .normal)
            textualButton.backgroundColor = Constants.darkGrayColor
            navigationButton.backgroundColor = Constants.lightGrayColor
            textualView.isHidden = false
            mapContainerView.isHidden = true
        case .navigation:
            textualButton.setTitleColor(Constants.blackishGrayColor, for: .normal)
            navigationButton.setTitleColor(.black, for: .normal)
            textualButton.backgroundColor = Constants.lightGrayColor
            navigationButton.backgroundColor = Constants.darkGrayColor
            textualView.isHidden = true
            mapContainerView.isHidden = false
        }
    }
}
