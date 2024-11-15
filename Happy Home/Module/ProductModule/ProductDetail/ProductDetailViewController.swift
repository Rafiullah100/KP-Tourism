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
    

   
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var likelyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var inStockButton: UIButton!
    
    @IBOutlet weak var orginLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var expiredLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
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
        navigationView.label.text = LocalizationKeys.viewProduct.rawValue.localizeString()
        expiredLabel.text = "\(LocalizationKeys.expiredDate.rawValue.localizeString()) 25/09/2024"
        sizeLabel.text = "\(LocalizationKeys.size.rawValue.localizeString()) - 300ML"
        oldPriceLabel.text = "4.5 \(LocalizationKeys.riyal.rawValue.localizeString())"
        newPriceLabel.text = "5.4 \(LocalizationKeys.riyal.rawValue.localizeString())"
        vatLabel.text = LocalizationKeys.incVAT.rawValue.localizeString()
        orginLabel.text = LocalizationKeys.orgin.rawValue.localizeString()
        inStockButton.setTitle("22 \(LocalizationKeys.inStock.rawValue.localizeString())", for: .normal)
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        likelyLabel.text = LocalizationKeys.youMightalsoLike.rawValue.localizeString()
        ratingLabel.text = "4.5 \(LocalizationKeys.rating.rawValue.localizeString())"
        addToCartButton.setTitle(LocalizationKeys.addToCart.rawValue.localizeString(), for: .normal)

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


