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
    
    override func show(_ vc: UIViewController, sender: Any?) {
        add(vc)
    }
}

extension LocalProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestProductCollectionViewCell.cellIdentifier, for: indexPath) as! DestProductCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: Storyboard.destination.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        show(vc, sender: self)
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


