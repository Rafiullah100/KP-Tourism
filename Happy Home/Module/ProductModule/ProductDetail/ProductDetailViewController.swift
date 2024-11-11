//
//  ProductDetailViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/9/24.
//

import UIKit

class ProductDetailViewController: UIViewController, ProductNavigationViewDelegate {
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBOutlet weak var navigationView: ProductNavigationView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    @IBAction func viewButtonAction(_ sender: Any) {
        Switcher.gotoGallery(delegate: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension ProductDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! ProductCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2.7
        let spaceBetweenCells: CGFloat = 5
        let sectionInset: CGFloat = 5
        let totalPadding = (cellsAcross - 1) * spaceBetweenCells + 2 * sectionInset
        let availableWidth = collectionView.bounds.width - totalPadding
        let width = availableWidth / cellsAcross
        return CGSize(width: width, height: 200)
    }
}


