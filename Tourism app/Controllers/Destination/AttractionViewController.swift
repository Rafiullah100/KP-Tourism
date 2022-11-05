//
//  AttractionViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit

class AttractionViewController: UIViewController {
    

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "DestAttractCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DestAttractCollectionViewCell.cellIdentifier)
        }
    }
    
    let vc: DestinatonViewController = UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "DestinatonViewController") as! DestinatonViewController

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AttractionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestAttractCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestAttractCollectionViewCell.cellIdentifier, for: indexPath) as! DestAttractCollectionViewCell
        return cell
    }
}

extension AttractionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width * 0.65)
    }
}

extension AttractionViewController: PopupDelegate{
    func showPopup() {
       // Switcher.gotoFilterVC(delegate: self)
    }
}

