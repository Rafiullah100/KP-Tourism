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
    
    @IBOutlet weak var shareButton: UIButton!
    
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
        desintationArray = [Destination(image: "gallery", title: "What to See"), Destination(image: "gallery", title: "Getting Here"), Destination(image: "gallery", title: "Point of Interest"), Destination(image: "gallery", title: "Accomodation"), Destination(image: "gallery", title: "Events"), Destination(image: "gallery", title: "Gallery"), Destination(image: "gallery", title: "Itinrary"), Destination(image: "gallery", title:"Local Products")]

    }

    override func showFilter() {
        filterView.isHidden = !filterView.isHidden
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
        Switcher.goToPOI(delegate: self)
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

