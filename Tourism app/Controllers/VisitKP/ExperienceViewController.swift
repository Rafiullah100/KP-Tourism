//
//  ExperienceViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/30/23.
//

import UIKit

class VisitExperienceCollectionViewCell: UICollectionViewCell {
    //
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var experience: Destination? {
        didSet {
            label.text = experience?.title
            bgImageView.image = UIImage(named: experience?.image ?? "")
        }
    }
}

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
        return Constants.visitExperienceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: VisitExperienceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! VisitExperienceCollectionViewCell
        cell.experience = Constants.visitExperienceArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoTourInformationVC(delegate: self)
    }
}

extension ExperienceViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 10, cellsAcross: 2)
    }
}
