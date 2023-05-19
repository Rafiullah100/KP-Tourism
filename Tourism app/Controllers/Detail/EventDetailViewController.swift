//
//  EventDetailViewController.swift
//  Tourism app
//
//  Created by Rafi on 08/11/2022.
//

import UIKit
import SDWebImage
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import MapboxMaps
import SVProgressHUD
class EventDetailViewController: BaseViewController {

    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var titLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var interestGoingLabel: UILabel!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    var eventDetail: EventListModel?
    internal var mapView: MapView!
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    var interestCount = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
//        viewControllerTitle = "Events, \(eventDetail?.locationTitle ?? "")"
        viewControllerTitle = ""
        viewControllerTitle = "\(eventDetail?.title ?? "") | Events"

        titLabel.text = eventDetail?.title
        eventTypeLabel.text = eventDetail?.locationTitle
        descriptionLabel.text = eventDetail?.eventDescription?.stripOutHtml()
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (eventDetail?.previewImage ?? "")))
        openDateLabel.text = "\(eventDetail?.startDate ?? "") | \(eventDetail?.isExpired ?? "")"
        if eventDetail?.isExpired == "Closed" {
            statusView.backgroundColor = .red
        }else{
            statusView.backgroundColor = Constants.appColor
        }
        interestCount = eventDetail?.usersInterestCount ?? 0
        interestGoingLabel.text = "\(String(describing: interestCount)) Interested"
        favoriteBtn.setImage(eventDetail?.userInterest == 1 ? UIImage(named: "interested-red") : UIImage(named: "interested"), for: .normal)
        view.bringSubviewToFront(statusView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        statusBarView.addGradient()
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
        guard let originCoordinate = originCoordinate, let lat: Double = Double(eventDetail?.latitude ?? ""),let lon: Double = Double(eventDetail?.longitude ?? "") else { return  }
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
    
    @IBAction func shareBtnAction(_ sender: Any) {
        self.share(text: eventDetail?.eventDescription ?? "", image: imageView.image ?? UIImage())
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        self.interest(route: .doEventInterest, method: .post, parameters: ["event_id": eventDetail?.id ?? 0], model: SuccessModel.self)
    }
    
    func interest<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let like):
                let successDetail = like as? SuccessModel
                self.favoriteBtn.setImage(UIImage(named: successDetail?.message == "Interest Added" ? "interested-red" : "interested"), for: .normal)
                self.interestCount = successDetail?.message == "Interest Added" ? self.interestCount + 1 : self.interestCount - 1
                self.interestGoingLabel.text = "\(self.interestCount) Interested"
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}

extension EventDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}
