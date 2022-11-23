//
//  InterestPointViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit

class PointOfInterestViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "InterestPointCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: InterestPointCollectionViewCell.cellIdentifier)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        add(vc)
    }
}

extension PointOfInterestViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: InterestPointCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestPointCollectionViewCell.cellIdentifier, for: indexPath) as! InterestPointCollectionViewCell
        return cell
    }
}

extension PointOfInterestViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = UIStoryboard(name: Storyboard.POI.rawValue, bundle: nil).instantiateViewController(withIdentifier: "POIServicesViewController") as! POIServicesViewController
//        show(vc, sender: self)
        Switcher.goToPOIServices(delegate: self)
    }
}

extension PointOfInterestViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 2
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width)
    }
}
