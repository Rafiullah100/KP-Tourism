//
//  LocalProductsViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

class LocalProductsViewController: UIViewController {
    @IBOutlet weak var collecttionView: UICollectionView!{
        didSet{
            collecttionView.delegate = self
            collecttionView.dataSource = self
            collecttionView.register(UINib(nibName: "DestProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DestProductCollectionViewCell.cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension LocalProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestProductCollectionViewCell.cellIdentifier, for: indexPath) as! DestProductCollectionViewCell
        cell.bgView.layer.borderWidth = 0.5
        cell.bgView.layer.borderColor = UIColor.lightGray.cgColor
        cell.bgView.layer.cornerRadius = 5.0
        return cell
    }
}

extension LocalProductsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 5
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width)
    }
}


