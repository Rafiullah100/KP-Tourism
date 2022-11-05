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
}

extension InterestPointViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: InterestPointCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestPointCollectionViewCell.cellIdentifier, for: indexPath) as! InterestPointCollectionViewCell
        return cell
    }
}

//extension InterestPointViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width * 0.65)
//    }
//}
