//
//  EventsViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit

class EventsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: EventCollectionViewCell.cellIdentifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EventsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EventCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.cellIdentifier, for: indexPath) as! EventCollectionViewCell
        cell.bgView.layer.borderWidth = 0.5
        cell.bgView.layer.borderColor = UIColor.lightGray.cgColor
        cell.bgView.layer.cornerRadius = 15.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoEventDetail(delegate: self)
    }
}

extension EventsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width * 0.95)
    }
}

