//
//  POIDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/12/23.
//

import UIKit
import SDWebImage
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import MapboxMaps
import SVProgressHUD
class POIDedetailCell: UICollectionViewCell {
    //
    @IBOutlet weak var imgView: UIImageView!
}

class POIDetailViewController: BaseViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    var poiDetail: POIRow?
    
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        descriptionLabel.text = poiDetail?.description.stripOutHtml()
        placeLabel.text = poiDetail?.locationTitle
        categoryLabel.text = poiDetail?.poiCategories.title
        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Poppins-Medium", size: 16) ?? UIFont()]
        let secondAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Poppins-Light", size: 12) ?? UIFont()]
        let name = NSMutableAttributedString(string: "\(poiDetail?.title ?? "") | ", attributes: firstAttributes)
        let poi = NSMutableAttributedString(string: "Point Of Interest", attributes: secondAttributes)
        name.append(poi)
        nameLabel.attributedText = name
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
        print(originCoordinate, poiDetail?.latitude, poiDetail?.longitude)
        guard let originCoordinate = originCoordinate, let lat: Double = Double(poiDetail?.latitude ?? ""), let lon: Double = Double(poiDetail?.longitude ?? "") else { return  }
        let origin = Waypoint(coordinate: originCoordinate, name: "")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), name: "")
        
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        SVProgressHUD.show(withStatus: "Please wait...")
        Directions(credentials: Credentials(accessToken: Constants.mapboxPublicKey)).calculate(routeOptions) { [weak self] (session, result) in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            case .success(let response):
                guard let self = self else { return }
                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
}

extension POIDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if poiDetail?.poiGalleries.count == 0{
            self.collectionView.setEmptyView("No Photos Found!")
        }
        else{
            return poiDetail?.poiGalleries.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: POIDedetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! POIDedetailCell
        cell.imgView.sd_setImage(with: URL(string: Route.baseUrl + (poiDetail?.poiGalleries[indexPath.row].imageURL ?? "")))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoViewerVC(delegate: self, position: indexPath, poiGallery: poiDetail?.poiGalleries, type: .poi)
    }
}

extension POIDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 10, cellsAcross: 2)
    }
}

extension POIDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}
