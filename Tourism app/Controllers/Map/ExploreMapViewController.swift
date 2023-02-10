//
//  ExploreMapViewController.swift
//  Tourism app
//
//  Created by Rafi on 01/11/2022.
//

import UIKit
import GoogleMaps

class ExploreMapViewController: UIViewController {

    var exploreDistrict: [ExploreDistrict]?
    var attractionDistrict: [AttractionsDistrict]?
    var eventDistrict: [EventListModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
    }
    
    private func loadMap(){
        let camera = GMSCameraPosition.camera(withLatitude: 35.2227, longitude: 72.4258, zoom: 7.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView.delegate = self
        view.addSubview(mapView)
    
        //explore
        exploreDistrict?.forEach({ district in
            let marker = GMSMarker()
            guard let latitude = Double(district.latitude ), let longitude = Double(district.longitude ) else { return }
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.iconView = UIImageView(image: UIImage(named: "marker")!.withRenderingMode(.alwaysOriginal))
            marker.userData = district.id
            marker.title = district.title
            marker.snippet = district.title
            marker.map = mapView
        })
        
        //attractions
        attractionDistrict?.forEach({ district in
            let marker = GMSMarker()
            guard let latitude = Double(district.latitude ?? ""), let longitude = Double(district.longitude ?? "") else { return }
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.iconView = UIImageView(image: UIImage(named: "marker")!.withRenderingMode(.alwaysOriginal))
            marker.userData = district.id
            marker.map = mapView
        })
        
        //events
        eventDistrict?.forEach({ district in
            let marker = GMSMarker()
            guard let latitude = Double(district.latitude ?? ""), let longitude = Double(district.longitude ?? "") else { return }
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.iconView = UIImageView(image: UIImage(named: "marker")!.withRenderingMode(.alwaysOriginal))
            marker.userData = district.id
            marker.map = mapView
        })
    }
}

extension ExploreMapViewController: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.userData ?? 0)
        mapView.selectedMarker = marker
        return true
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
}
