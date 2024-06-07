//
//  FilterView.swift
//  Tourism app
//
//  Created by Rafi on 04/11/2022.
//

import UIKit

protocol FilterDelegate {
    func applyFilter(ids: String)
}

class FilterView: UIView {
        @IBAction func searchTextField(_ sender: Any) {
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "SearchTagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SearchTagCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    @IBOutlet weak var collectionviewHeight: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var containerView: UIView!
    var delegate: FilterDelegate?

    var selectedIndexPaths = Set<IndexPath>()
    var categories: [Category]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }
    
    @IBAction func backGroundTapped(_ sender: Any) {
        self.isHidden = true
    }
    private func commoninit(){
        let filterView = Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)![0] as! UIView
        filterView.frame = self.bounds
        filterView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        containerView.viewShadow()
        
       
        addSubview(filterView)

        
//        collectionviewHeight.constant = collectionView.contentSize.height
//        collectionView.reloadData()
    }
    
    
    @IBAction func refreshBtn(_ sender: Any) {
        selectedIndexPaths = []
        collectionView.reloadData()
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        guard selectedIndexPaths != [] else {
            self.makeToast("please select any category.")
            return
        }
        var arr = [Int]()
        selectedIndexPaths.forEach { index in
            print(index, categories?[index.row].id ?? 0)
            arr.append(categories?[index.row].id ?? 0)
            print(arr)
        }
        delegate?.applyFilter(ids: arr.map{String($0)}.joined(separator: ","))
    }
}

extension FilterView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchTagCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchTagCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! SearchTagCollectionViewCell
        cell.label.text = (categories?[indexPath.row].title ?? "") + " ( " + "\(categories?[indexPath.row].count ?? 0)" + " )"
        if selectedIndexPaths.contains(indexPath) {
            cell.imgView.image = UIImage(named: "selected-check")
        } else {
            cell.imgView.image = UIImage(named: "unselected-check")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPaths.contains(indexPath) {
            selectedIndexPaths.remove(indexPath)
        } else {
            selectedIndexPaths.insert(indexPath)
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 10
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: 50)
    }
}

