//
//  AttractionViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import SwiftGifOrigin
import CoreLocation
protocol PopupDelegate {
    func showPopup()
}

class CommonViewController: BaseViewController {
        
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var filterView: FilterView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(UINib(nibName: "DestinationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DestinationCollectionViewCell.cellReuseIdentifier())
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    var locationCategory: LocationCategory?
    var destinationArray: [Destination]?
    var explore: ExploreDistrict?
    var attraction: AttractionsDistrict?
    var archeology: Archeology?
    var wishlistAttraction: WishlistAttraction?
    var wishlistDistrict: WishlistDistrict?
    var districtID = 0
    
    
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    var latitude: String?
    var longitude: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .back1
        destinationArray = Constants.desintationArray
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeight.constant = collectionView.contentSize.height
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
    
    @IBAction func gotoAbout(_ sender: Any) {
        Switcher.gotoAbout(delegate: self, exploreDetail: explore, attractionDistrict: attraction, archeology: archeology, wishlistAttraction: wishlistAttraction, wishlistDistrict: wishlistDistrict)
    }
    
    func updateUI() {
        switch locationCategory {
        case .district:
            destinationArray?[0] = Destination(image: "dest-0", title: "Attractions")
        case .tourismSpot:
            destinationArray?[0] = Destination(image: "dest-0", title: "What to see")
        case .none:
            print("none")
        }
        
        if explore != nil{
            thumbnailTopLabel.text = explore?.title
            thumbnailBottomLabel.text = explore?.geographicalArea
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (explore?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder.png"))
            welcomeLabel.text = "Welcome to \(explore?.title ?? "")"
            descriptionLabel.text = explore?.description?.htmlToAttributedString
            districtID = explore?.id ?? 0
            latitude = explore?.latitude
            longitude = explore?.longitude
        }
        else if attraction != nil{
            thumbnailTopLabel.text = attraction?.title
            thumbnailBottomLabel.text = attraction?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attraction?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder.png"))
            welcomeLabel.text = "Welcome to \(attraction?.title ?? "")"
            descriptionLabel.text = attraction?.description.htmlToAttributedString
            latitude = attraction?.latitude
            longitude = attraction?.longitude
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnailBottomLabel.text = archeology?.attractions.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")), placeholderImage: UIImage(named: "placeholder.png"))
            welcomeLabel.text = "Welcome to \(archeology?.attractions.title ?? "")"
            descriptionLabel.text = archeology?.attractions.description?.htmlToAttributedString
            districtID = archeology?.attractions.id ?? 0
            latitude = archeology?.attractions.latitude
            longitude = archeology?.attractions.longitude
        }
        else if wishlistAttraction != nil{
            thumbnailTopLabel.text = wishlistAttraction?.title
            thumbnailBottomLabel.text = wishlistAttraction?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistAttraction?.displayImage ?? "")), placeholderImage: UIImage(named: "placeholder.png"))
            welcomeLabel.text = "Welcome to \(wishlistAttraction?.title ?? "")"
            descriptionLabel.text = wishlistAttraction?.description?.htmlToAttributedString
            districtID = wishlistAttraction?.id ?? 0
            latitude = wishlistAttraction?.latitude
            longitude = wishlistAttraction?.longitude
        }
        else if wishlistDistrict != nil{
            thumbnailTopLabel.text = wishlistDistrict?.title
            thumbnailBottomLabel.text = wishlistDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistDistrict?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder.png"))
            welcomeLabel.text = "Welcome to \(wishlistDistrict?.title ?? "")"
            descriptionLabel.text = wishlistDistrict?.description?.htmlToAttributedString
            districtID = wishlistDistrict?.id ?? 0
            latitude = wishlistDistrict?.latitude
            longitude = wishlistDistrict?.longitude
        }
    }
}

extension CommonViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return destinationArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestinationCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestinationCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! DestinationCollectionViewCell
        cell.destination = destinationArray?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            guard let locationCategory = locationCategory else { return }
            print(locationCategory)
            Switcher.goToAttraction(delegate: self, locationCategory: locationCategory, exploreDistrict: explore, attractionDistrict: attraction, archeology: archeology, districtID: districtID, wishlistAttraction: wishlistAttraction, wishlistDistrict: wishlistDistrict)
//        case 1:
//            Switcher.goToGettingHere(delegate: self, locationCategory: .district, exploreDistrict: explore, attractionDistrict: attraction, archeology: archeology)
        case 1:
            Switcher.goToPOI(delegate: self, locationCategory: .district, exploreDistrict: explore, attractionDistrict: attraction, archeology: archeology, wishlistAttraction: wishlistAttraction, wishlistDistrict: wishlistDistrict)
        case 2:
            Switcher.goToAccomodation(delegate: self, exploreDistrict: explore, attractionDistrict: attraction, archeology: archeology, wishlistAttraction: wishlistAttraction, wishlistDistrict: wishlistDistrict)
        case 3:
            Switcher.goToEvents(delegate: self, exploreDistrict: explore, attractionDistrict: attraction, archeology: archeology, wishlistAttraction: wishlistAttraction, wishlistDistrict: wishlistDistrict)
        case 4:
            Switcher.gotoGallery(delegate: self, exploreDistrict: explore, attractionDistrict: attraction, mediaType: .image, archeology: archeology, wishlistAttraction: wishlistAttraction, wishlistDistrict: wishlistDistrict)
        case 5:
            Switcher.goToItinrary(delegate: self, locationCategory: .district, exploreDistrict: explore, attractionDistrict: attraction, archeology: archeology, wishlistAttraction: wishlistAttraction, wishlistDistrict: wishlistDistrict)
        case 6:
            Switcher.goToProducts(delegate: self, exploreDistrict: explore, attractionDistrict: attraction, archeology: archeology, wishlistAttraction: wishlistAttraction, wishlistDistrict: wishlistDistrict)
        case 7:
            guard let originCoordinate = originCoordinate, let lat: Double = Double(latitude ?? ""), let lon: Double = Double(longitude ?? "") else {
                self.view.makeToast(Constants.noCoordinate)
                return  }
            getDirection(originCoordinate: originCoordinate, destinationCoordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
        default:
            break
        }
    }
}

extension CommonViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 3
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width - 25)
    }
}

extension CommonViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}
