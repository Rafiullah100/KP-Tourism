//
//  InterestPointViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit

class InterestPointViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "InterestPointCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: InterestPointCollectionViewCell.cellIdentifier)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        add(vc)
    }
}

extension InterestPointViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: InterestPointCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestPointCollectionViewCell.cellIdentifier, for: indexPath) as! InterestPointCollectionViewCell
        return cell
    }
}

extension InterestPointViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: Storyboard.POI.rawValue, bundle: nil).instantiateViewController(withIdentifier: "POIServicesViewController") as! POIServicesViewController
        show(vc, sender: self)
    }
}

extension InterestPointViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 2
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width)
    }
}
