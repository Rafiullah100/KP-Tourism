//
//  ExploreMapViewController.swift
//  Tourism app
//
//  Created by Rafi on 01/11/2022.
//

import UIKit
import GoogleMaps

class ExploreMapViewController: UIViewController {

    let arr = [Coordinates(lat: 35.2227, long: 72.4258), Coordinates(lat: 35.2072, long: 72.5456), Coordinates(lat: 35.1404, long: 72.5353), Coordinates(lat: 35.1706, long: 72.3711)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 35.2227, longitude: 72.4258, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView.delegate = self
        view.addSubview(mapView)
    
        for item in arr {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
            marker.iconView = CustomMakerView(frame: CGRect(x: 0, y: 0, width: 55, height: 30))
            marker.icon = UIImage(named: "marker")
            marker.userData = item
            marker.map = mapView
        }
    }
}

extension ExploreMapViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.userData ?? 0)
        return true
    }
}
