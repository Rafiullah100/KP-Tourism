//
//  SearchViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/10/24.
//

import UIKit
class SearchViewController: UIViewController {

    @IBOutlet weak var likelyLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var categoryCollectionViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var historyCollectionViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var productCollectionView: UICollectionView! {
        didSet {
            productCollectionView.delegate = self
            productCollectionView.dataSource = self
            productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    @IBOutlet weak var historyCollectionView: UICollectionView! {
        didSet {
            historyCollectionView.delegate = self
            historyCollectionView.dataSource = self
            historyCollectionView.register(UINib(nibName: "searchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: searchCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!{
        didSet {
            categoriesCollectionView.delegate = self
            categoriesCollectionView.dataSource = self
            categoriesCollectionView.register(UINib(nibName: "searchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: searchCollectionViewCell.cellReuseIdentifier())
        }
    }
    var historyArr = ["Kunufa", "Creamy Cake" , "Mustard Pants",  "Bracelet", "Tutors"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchLabel.text = LocalizationKeys.search.rawValue.localizeString()
        historyLabel.text = LocalizationKeys.searchHistory.rawValue.localizeString()
        categoryLabel.text = LocalizationKeys.categories.rawValue.localizeString()
        likelyLabel.text = LocalizationKeys.youMightalsoLike.rawValue.localizeString()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewHeight()
    }
    
    private func updateCollectionViewHeight() {
        historyCollectionViewHeightContraint.constant = historyCollectionView.collectionViewLayout.collectionViewContentSize.height
        categoryCollectionViewHeightContraint.constant = categoriesCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCollectionView {
            return 10
        } else {
            return historyArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! ProductCollectionViewCell
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! searchCollectionViewCell
            cell.label.text = historyArr[indexPath.row]
            return cell
        }
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
