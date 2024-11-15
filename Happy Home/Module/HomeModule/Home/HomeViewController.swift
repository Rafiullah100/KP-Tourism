//
//  HomeViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/14/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var offerCollectionView: UICollectionView!{
        didSet{
            offerCollectionView.delegate = self
            offerCollectionView.dataSource = self
            offerCollectionView.register(UINib(nibName: "OffersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: OffersCollectionViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var arrowIcon: UIImageView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!{
        didSet{
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
            categoryCollectionView.register(UINib(nibName: "MainCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MainCategoriesCollectionViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var productCollectionView: UICollectionView!{
        didSet{
            productCollectionView.delegate = self
            productCollectionView.dataSource = self
            productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var topItemLabel: UILabel!
    @IBOutlet weak var brandsCollectionView: UICollectionView!{
        didSet{
            brandsCollectionView.delegate = self
            brandsCollectionView.dataSource = self
            brandsCollectionView.register(UINib(nibName: "BrandsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BrandsCollectionViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var cartRiyalLabel: UILabel!
    @IBOutlet weak var deliveryToLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deliveryToLabel.text = LocalizationKeys.deliveryTo.rawValue.localizeString()
        topItemLabel.text = LocalizationKeys.topItems.rawValue.localizeString()
        categoryLabel.text = LocalizationKeys.categories.rawValue.localizeString()
        cartRiyalLabel.text = LocalizationKeys.riyal.rawValue.localizeString()
        viewAllButton.setTitle(LocalizationKeys.viewAll.rawValue.localizeString(), for: .normal)
        arrowIcon.image = UIImage(named: Helper.shared.isRTL() ? "ar-thin-arrow" : "thin-arrow")
    }

    @IBAction func cartButtonAction(_ sender: Any) {
        Switcher.gotoCart(delegate: self)
    }
    
    @IBAction func viewAllButtonAction(_ sender: Any) {
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == brandsCollectionView{
            return 10
        }
        else if collectionView == productCollectionView{
            return 10
        }
        else if collectionView == categoryCollectionView{
            return 10
        }
        else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == brandsCollectionView{
            let cell: BrandsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandsCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! BrandsCollectionViewCell
            return cell
        }
        else if collectionView == productCollectionView{
            let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! ProductCollectionViewCell
            return cell
        }
        else if collectionView == categoryCollectionView{
            let cell: MainCategoriesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! MainCategoriesCollectionViewCell
            return cell
        }
        else {
            let cell: OffersCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: OffersCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! OffersCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == brandsCollectionView{
            return CGSize(width: 90, height: 90)
        }
        else if collectionView == productCollectionView {
            let cellsAcross: CGFloat = 2.5
            let spaceBetweenCells: CGFloat = 0
            let sectionInset: CGFloat = 5
            let totalPadding = (cellsAcross - 1) * spaceBetweenCells + 2 * sectionInset
            let availableWidth = collectionView.bounds.width - totalPadding
            let width = availableWidth / cellsAcross
            return CGSize(width: width, height: 235)
        }
        else if collectionView == categoryCollectionView {
            let cellsAcross: CGFloat = 3
            let spaceBetweenCells: CGFloat = 5
            let sectionInset: CGFloat = 5
            let totalPadding = (cellsAcross - 1) * spaceBetweenCells + 2 * sectionInset
            let availableWidth = collectionView.bounds.width - totalPadding
            let width = availableWidth / cellsAcross
            return CGSize(width: width, height: width)
        }
        else{
           return CGSize(width: 150, height: 150)
        }
    }
}
