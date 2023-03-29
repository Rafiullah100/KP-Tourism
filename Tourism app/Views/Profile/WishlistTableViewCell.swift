//
//  WishlistTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/8/22.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "WishlistCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: WishlistCollectionViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var label: UILabel!
    
    var postWishlist: [PostWishlistModel]?{
        didSet{
            label.text = "Post"
            collectionView.reloadData()
        }
    }
    
    var attractionWishlist: [AttractionWishlistModel]?{
        didSet{
            label.text = "Attraction"
            collectionView.reloadData()
        }
    }
    
    var districtWishlist: [DistrictWishlistModel]?{
        didSet{
            label.text = "District"
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension WishlistTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !(postWishlist?.isEmpty ?? true){
            return postWishlist?.count ?? 0
        }
        else if !(attractionWishlist?.isEmpty ?? true){
            return attractionWishlist?.count ?? 0
        }
        else if !(districtWishlist?.isEmpty ?? true){
            return districtWishlist?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WishlistCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: WishlistCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! WishlistCollectionViewCell
        if !(postWishlist?.isEmpty ?? true){
            cell.postWishlist = postWishlist?[indexPath.row]
        }
        else if !(attractionWishlist?.isEmpty ?? true){
            cell.attractionWishlist = attractionWishlist?[indexPath.row]
        }
        else if !(districtWishlist?.isEmpty ?? true){
            cell.districtWishlist = districtWishlist?[indexPath.row]
        }
        return cell
    }
}

extension WishlistTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
}
