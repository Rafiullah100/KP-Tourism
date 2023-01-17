//
//  AttractionViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import SwiftGifOrigin
protocol PopupDelegate {
    func showPopup()
}

class CommonViewController: BaseViewController {
        
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
    var delegate: PopupDelegate?
    var locationCategory: LocationCategory?
    var destinationArray: [Destination]?
    var explore: ExploreDistrict?
    var attraction: AttractionsDistrict?
    var archeology: Archeology?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .back1
        destinationArray = Constants.desintationArray
        updateUI()
    }
    
    @IBAction func gotoAbout(_ sender: Any) {
        Switcher.gotoAbout(delegate: self, exploreDetail: explore, attractionDistrict: attraction)
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
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (explore?.thumbnailImage ?? "")), placeholderImage: UIImage(named: "placeholder.png"))
            welcomeLabel.text = "Welcome to \(explore?.title ?? "")"
            descriptionLabel.text = explore?.description?.stripOutHtml()
        }
        else if attraction != nil{
            thumbnailTopLabel.text = attraction?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attraction?.displayImage ?? "")), placeholderImage: UIImage(named: "placeholder.png"))
            welcomeLabel.text = "Welcome to \(attraction?.title ?? "")"
            descriptionLabel.text = attraction?.description.stripOutHtml()
        }
//        else if archeology != nil{
//            thumbnailTopLabel.text = archeology?.title
//            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.image_url ?? "")), placeholderImage: UIImage(named: "placeholder.png"))
//            welcomeLabel.text = "Welcome to \(archeology?.title ?? "")"
//            descriptionLabel.text = archeology?.
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            Switcher.goToAttraction(delegate: self, locationCategory: locationCategory, exploreDistrict: explore, attractionDistrict: attraction)
        case 1:
            Switcher.goToGettingHere(delegate: self, locationCategory: .district, exploreDistrict: explore, attractionDistrict: attraction)
        case 2:
            Switcher.goToPOI(delegate: self, locationCategory: .district, exploreDistrict: explore, attractionDistrict: attraction)
        case 3:
            Switcher.goToAccomodation(delegate: self, locationCategory: .district)
        case 4:
            Switcher.goToEvents(delegate: self, exploreDistrict: explore, attractionDistrict: attraction)
        case 5:
            Switcher.gotoGallery(delegate: self, exploreDistrict: explore, attractionDistrict: attraction)
        case 6:
            Switcher.goToItinrary(delegate: self, locationCategory: .district, exploreDistrict: explore, attractionDistrict: attraction)
        case 7:
            Switcher.goToProducts(delegate: self, exploreDistrict: explore, attractionDistrict: attraction)
        default:
            break
        }
    }
}


extension CommonViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 4
        let spaceBetweenCells: CGFloat = 2
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        print(width)
        return CGSize(width: width, height: width - 30)
    }
}

