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
    @IBOutlet weak var containerView: UIView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    
    @IBOutlet weak var travelTypeLabel: UILabel!
    var locationCategory: LocationCategory?
    var locationManager: CLLocationManager!
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    
    
    var travelVC: TravelViewController {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "TravelViewController") as! TravelViewController
    }
    var navigationVC: NavigationViewController {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "NavigationViewController") as! NavigationViewController
    }
    
    var travel: Travel?
    
    var gettingHere: GettingHereModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1

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
        let vc: TravelViewController = UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "TravelViewController") as! TravelViewController
        vc.gettingArray = gettingHere?.gettingHeres
        add(vc, in: containerView)
    }

//    }
    
    @IBAction func textualButtonAction(_ sender: Any) {
        show(travelVC, sender: self)
    }
    
    @IBAction func mapBtnAction(_ sender: Any) {
        show(navigationVC, sender: self)
    }
    
    
    @IBAction func naviigationButtonAction(_ sender: Any) {
//        Switcher.goToNavigation(delegate: self, locationCategory: locationCategory!)
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
