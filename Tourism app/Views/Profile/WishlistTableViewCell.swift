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
    var wishlistCallback : ((_ section: wishlistSection, _ index: Int) -> Void)?
    var wishlistDeleteCallback : ((_ section: wishlistSection, _ index: Int) -> Void)?

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
    
    var packageWishlist: [PackageWishlistModel]?{
        didSet{
            label.text = "Tour Package"
            collectionView.reloadData()
        }
    }
    
    var productWishlist: [ProductWishlistModel]?{
        didSet{
            label.text = "Local Product"
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
        else if !(packageWishlist?.isEmpty ?? true){
            return packageWishlist?.count ?? 0
        }
        else if !(productWishlist?.isEmpty ?? true){
            return productWishlist?.count ?? 0
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
        else if !(packageWishlist?.isEmpty ?? true){
            cell.packageWishlist = packageWishlist?[indexPath.row]
        }
        else if !(productWishlist?.isEmpty ?? true){
            cell.productWishlist = productWishlist?[indexPath.row]
        }
        
        cell.deleteCallback = {
            if !(self.postWishlist?.isEmpty ?? true){
                self.wishlistDeleteCallback?(.post, indexPath.row)
            }
            else if !(self.attractionWishlist?.isEmpty ?? true){
                self.wishlistDeleteCallback?(.attraction, indexPath.row)
            }
            else if !(self.districtWishlist?.isEmpty ?? true){
                self.wishlistDeleteCallback?(.district, indexPath.row)
            }
            else if !(self.packageWishlist?.isEmpty ?? true){
                self.wishlistDeleteCallback?(.package, indexPath.row)
            }
            else if !(self.productWishlist?.isEmpty ?? true){
                self.wishlistDeleteCallback?(.product, indexPath.row)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !(postWishlist?.isEmpty ?? true){
            wishlistCallback?(.post, indexPath.row)
        }
        else if !(attractionWishlist?.isEmpty ?? true){
            wishlistCallback?(.attraction, indexPath.row)
        }
        else if !(districtWishlist?.isEmpty ?? true){
            wishlistCallback?(.district, indexPath.row)
        }
        else if !(packageWishlist?.isEmpty ?? true){
            wishlistCallback?(.package, indexPath.row)
        }
        else if !(productWishlist?.isEmpty ?? true){
            wishlistCallback?(.product, indexPath.row)
        }
    }
}

extension WishlistTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
}
