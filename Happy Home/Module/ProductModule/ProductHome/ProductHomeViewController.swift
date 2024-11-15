//
//  ProductHomeViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/9/24.
//

import UIKit

class ProductHomeViewController: UIViewController {

    @IBOutlet weak var riyalLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!{
        didSet{
            categoryCollectionView.register(UINib(nibName: "ProductCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCategoryCollectionViewCell.cellReuseIdentifier())
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var productCollectionView: UICollectionView!{
        didSet{
            productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier())
            productCollectionView.delegate = self
            productCollectionView.dataSource = self
        }
    }
    
    let arr = ["All", "Frozen", "Drink & Water", "Meat", "Vegitables", "Dairy"]
    var selectedCategoryIndex = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = LocalizationKeys.allProducts.rawValue.localizeString()
        riyalLabel.text = LocalizationKeys.riyal.rawValue.localizeString()

        categoryCollectionView.showsHorizontalScrollIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension ProductHomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCollectionView{
            return 20
        }
        else{
            return arr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! ProductCollectionViewCell
            cell.didTapButton = {
                cell.addView.isHidden = true
            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCategoryCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! ProductCategoryCollectionViewCell
            cell.configure(with: arr[indexPath.row], isSelected: indexPath.item == selectedCategoryIndex)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 0
        let sectionInset: CGFloat = 0
        let totalPadding = (cellsAcross - 1) * spaceBetweenCells + 2 * sectionInset
        let availableWidth = collectionView.bounds.width - totalPadding
        let width = availableWidth / cellsAcross
        return CGSize(width: width, height: 235)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == productCollectionView{
            Switcher.gotoProductDetail(delegate: self)
        }
        else{
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            selectedCategoryIndex = indexPath.item
            collectionView.reloadData()
        }
    }
}
