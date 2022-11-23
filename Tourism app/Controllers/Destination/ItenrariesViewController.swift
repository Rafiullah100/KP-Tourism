//
//  ItenrariesViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

class ItenrariesViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ItenrariesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ItenrariesCollectionViewCell.cellIdentifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
    }
}

extension ItenrariesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItenrariesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItenrariesCollectionViewCell.cellIdentifier, for: indexPath) as! ItenrariesCollectionViewCell
        return cell
    }
}

extension ItenrariesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 5
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width*1.2)
        
    }
}


