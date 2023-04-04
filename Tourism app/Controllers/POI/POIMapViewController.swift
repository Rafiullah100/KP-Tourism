//
//  POIMapViewController.swift
//  Tourism app
//
//  Created by Rafi on 07/11/2022.
//

import UIKit
import Mapbox
class POIMapViewController: BaseViewController {
        
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var seacrhBgView: UIView!
    var locationCategory: LocationCategory?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var POISubCatories: POISubCatoriesModel?
    var mapView = MGLMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        loadMap()
    }
    
    func loadMap() {
        let url = URL(string: "mapbox://styles/mapbox/streets-v12")
        let mapView = MGLMapView(frame: mapViewContainer.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: Constants.kpkCoordinates.lat, longitude: Constants.kpkCoordinates.long), zoomLevel: 7, animated: false)
        mapView.styleURL = MGLStyle.streetsStyleURL
        mapView.tintColor = .darkGray
        mapViewContainer.addSubview(mapView)
        
        POISubCatories?.pois.rows.forEach({ point in
            guard let lat = Double(point.latitude ?? ""), let lon = Double(point.longitude ?? "")  else { return }
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            mapView.addAnnotation(point)
        })
    }
    
    @IBAction func listBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        //        guard let district = district else { return }
        //        Switcher.goToPOIServices(delegate: self, locationCategory: locationCategory!, district: district)
    }
}
