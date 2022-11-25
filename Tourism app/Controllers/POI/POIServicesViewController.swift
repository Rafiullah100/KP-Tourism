//
//  POIServicesViewController.swift
//  Tourism app
//
//  Created by Rafi on 07/11/2022.
//

import UIKit

class POIServicesViewController: BaseViewController {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    var locationCategory: LocationCategory?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        updateUI()
    }
    
//    override func show(_ vc: UIViewController, sender: Any?) {
//        add(vc)
//    }
    
    
    func updateUI() {
        switch locationCategory {
        case .district:
            thumbnailTopLabel.text = "Swat"
            thumbnailBottomLabel.text = "KP"
            thumbnail.image = UIImage(named: "Path 94")
        case .tourismSpot:
            thumbnailTopLabel.text = "Kalam"
            thumbnailBottomLabel.text = "Swat"
            thumbnail.image = UIImage(named: "iten")
        default:
            break
        }
    }
}


extension POIServicesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ServicesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionViewCell.cellIdentifier, for: indexPath) as! ServicesCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.goToPOIMap(delegate: self, locationCategory: locationCategory!)
//        let vc = UIStoryboard(name: Storyboard.POI.rawValue, bundle: nil).instantiateViewController(withIdentifier: "POIMapViewController") as! POIMapViewController
//        show(vc, sender: self)
    }
}

extension POIServicesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 2
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width*0.8)
    }
}
