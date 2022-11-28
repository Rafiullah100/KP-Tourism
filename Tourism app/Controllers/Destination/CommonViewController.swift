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
    var locationCategory: LocationCategory = .district
    var desintationArray: [Destination]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .back1
        desintationArray = [Destination(image: "dest-0", title: "What to See"), Destination(image: "dest-1", title: "Getting Here"), Destination(image: "dest-2", title: "Point of Interest"), Destination(image: "dest-3", title: "Accomodation"), Destination(image: "dest-4", title: "Events"), Destination(image: "dest-5", title: "Gallery"), Destination(image: "dest-6", title: "Itinrary"), Destination(image: "dest-7", title:"Local Products")]
        updateUI()
    }

//    override func showFilter() {
//        filterView.isHidden = !filterView.isHidden
//    }
    
    @IBAction func gotoAbout(_ sender: Any) {
        Switcher.gotoAbout(delegate: self, locationCategory: locationCategory)
    }
    
    func updateUI() {
        switch locationCategory {
        case .district:
            thumbnailTopLabel.text = "Swat"
            thumbnailBottomLabel.text = "KP"
            welcomeLabel.text = "Welcome to Swat"
            thumbnail.image = UIImage(named: "Path 94")
        case .tourismSpot:
            thumbnailTopLabel.text = "Kalam"
            thumbnailBottomLabel.text = "Swat"
            welcomeLabel.text = "Welcome to Kalam"
            thumbnail.image = UIImage(named: "iten")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension CommonViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestinationCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestinationCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! DestinationCollectionViewCell
        cell.destination = desintationArray?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            Switcher.goToAttraction(delegate: self, locationCategory: locationCategory)
        case 1:
            Switcher.goToGettingHere(delegate: self, locationCategory: locationCategory)
        case 2:
            Switcher.goToPOI(delegate: self, locationCategory: locationCategory)
        case 3:
            Switcher.goToAccomodation(delegate: self, locationCategory: locationCategory)
        case 4:
            Switcher.goToEvents(delegate: self, locationCategory: locationCategory)
        case 5:
            Switcher.gotoGalleryDetail(delegate: self)
        case 6:
            Switcher.goToItinrary(delegate: self, locationCategory: locationCategory)
        case 7:
            Switcher.goToProducts(delegate: self, locationCategory: locationCategory)
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

