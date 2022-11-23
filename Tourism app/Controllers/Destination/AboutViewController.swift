//
//  AboutViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

class AboutViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "AboutCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AboutCollectionViewCell.cellIdentifier)
        }
    }
    
    var contacts: [Contacts]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        contacts = [Contacts(photo: "Food", department: "Food", phone: "+91 123 4567"), Contacts(photo: "Hospital", department: "HOSPITAL", phone: "+91 123 4567"), Contacts(photo: "police", department: "POLICE", phone: "+91 123 4567"), Contacts(photo: "police-car", department: "POLICE", phone: "+91 123 4567")]
    }
}


extension AboutViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AboutCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutCollectionViewCell.cellIdentifier, for: indexPath) as! AboutCollectionViewCell
        cell.contact = contacts![indexPath.row]
        return cell
    }
}

extension AboutViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 2
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width*0.7)
    }
}



