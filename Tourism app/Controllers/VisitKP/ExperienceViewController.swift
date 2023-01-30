//
//  ExperienceViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/30/23.
//

import UIKit

class ExperienceViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var collectionViewHeigh: NSLayoutConstraint!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .visitKP
        viewControllerTitle = "Tour Planner"
        collectionViewHeigh.constant = CGFloat.greatestFiniteMagnitude
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionViewHeigh.constant = collectionView.contentSize.height
    }
}

extension ExperienceViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoTourDestinationVC(delegate: self)
    }
}

extension ExperienceViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 10, cellsAcross: 2)
    }
}
