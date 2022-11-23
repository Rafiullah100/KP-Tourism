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

class DestinatonHomeViewController: BaseViewController {
        
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var filterView: FilterView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(UINib(nibName: "DestinationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DestinationCollectionViewCell.cellReuseIdentifier())
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    var delegate: PopupDelegate?
    var desintationArray: [Destination]? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .back1
        desintationArray = [Destination(image: "dest-0", title: "What to See"), Destination(image: "dest-1", title: "Getting Here"), Destination(image: "dest-2", title: "Point of Interest"), Destination(image: "dest-3", title: "Accomodation"), Destination(image: "dest-4", title: "Events"), Destination(image: "dest-5", title: "Gallery"), Destination(image: "dest-6", title: "Itinrary"), Destination(image: "dest-7", title:"Local Products")]

    }

    override func showFilter() {
        filterView.isHidden = !filterView.isHidden
    }
    
    @IBAction func gotoAbout(_ sender: Any) {
        Switcher.gotoAbout(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension DestinatonHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
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
            Switcher.goToAttraction(delegate: self)
        case 1:
            Switcher.goToGettingHere(delegate: self)
        case 2:
            Switcher.goToPOI(delegate: self)
        case 3:
            Switcher.goToAccomodation(delegate: self)
        case 4:
            Switcher.goToEvents(delegate: self)
        case 5:
            Switcher.gotoGalleryDetail(delegate: self)
        case 6:
            Switcher.goToItinrary(delegate: self)
        case 7:
            Switcher.goToProducts(delegate: self)
        default:
            break
        }
    }
}


extension DestinatonHomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 4
        let spaceBetweenCells: CGFloat = 2
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        print(width)
        return CGSize(width: width, height: width - 30)
    }
}

