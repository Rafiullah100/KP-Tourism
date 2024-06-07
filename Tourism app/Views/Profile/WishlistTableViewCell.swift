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

    var wishlistType: wishlistSection?
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
    
    var eventWishlist: [EventWishlistModel]?{
        didSet{
            label.text = "Social Event"
            collectionView.reloadData()
        }
    }
    
    var blogWishlist: [BlogWishlistModel]?{
        didSet{
            label.text = "Blogs"
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
        if wishlistType == .post{
            postWishlist?.count == 0 ? collectionView.setEmptyView("No post added to wishlist") : collectionView.setEmptyView("")
            return postWishlist?.count ?? 0
        }
        else if wishlistType == .attraction{
            attractionWishlist?.count == 0 ? collectionView.setEmptyView("No attraction added to wishlist") : collectionView.setEmptyView("")
            return attractionWishlist?.count ?? 0
        }
        else if wishlistType == .district{
            districtWishlist?.count == 0 ? collectionView.setEmptyView("No district added to wishlist") : collectionView.setEmptyView("")
            return districtWishlist?.count ?? 0
        }
        else if wishlistType == .package{
            packageWishlist?.count == 0 ? collectionView.setEmptyView("No Tour package added to wishlist") : collectionView.setEmptyView("")
            return packageWishlist?.count ?? 0
        }
        else if wishlistType == .product{
            productWishlist?.count == 0 ? collectionView.setEmptyView("No Local Product added to wishlist") : collectionView.setEmptyView("")
            return productWishlist?.count ?? 0
        }
        else if wishlistType == .event{
            eventWishlist?.count == 0 ? collectionView.setEmptyView("No event added to wishlist") : collectionView.setEmptyView("")
            return eventWishlist?.count ?? 0
        }
        else if wishlistType == .blog{
            blogWishlist?.count == 0 ? collectionView.setEmptyView("No blog added to wishlist") : collectionView.setEmptyView("")
            return blogWishlist?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WishlistCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: WishlistCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! WishlistCollectionViewCell
        if wishlistType == .post{
            cell.postWishlist = postWishlist?[indexPath.row]
        }
        else if wishlistType == .attraction{
            cell.attractionWishlist = attractionWishlist?[indexPath.row]
        }
        else if wishlistType == .district{
            cell.districtWishlist = districtWishlist?[indexPath.row]
        }
        else if wishlistType == .package{
            cell.packageWishlist = packageWishlist?[indexPath.row]
        }
        else if wishlistType == .product{
            cell.productWishlist = productWishlist?[indexPath.row]
        }
        else if wishlistType == .event{
            cell.eventWishlist = eventWishlist?[indexPath.row]
        }
        else if wishlistType == .blog{
            cell.blogWishlist = blogWishlist?[indexPath.row]
        }
        
        cell.deleteCallback = {
            if self.wishlistType == .post{
                self.wishlistDeleteCallback?(.post, indexPath.row)
            }
            else if self.wishlistType == .attraction{
                self.wishlistDeleteCallback?(.attraction, indexPath.row)
            }
            else if self.wishlistType == .district{
                self.wishlistDeleteCallback?(.district, indexPath.row)
            }
            else if self.wishlistType == .package{
                self.wishlistDeleteCallback?(.package, indexPath.row)
            }
            else if self.wishlistType == .product{
                self.wishlistDeleteCallback?(.product, indexPath.row)
            }
            else if self.wishlistType == .event{
                self.wishlistDeleteCallback?(.event, indexPath.row)
            }
            else if self.wishlistType == .blog{
                self.wishlistDeleteCallback?(.blog, indexPath.row)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if wishlistType == .post{
            wishlistCallback?(.post, indexPath.row)
        }
        else if wishlistType == .attraction{
            wishlistCallback?(.attraction, indexPath.row)
        }
        else if wishlistType == .district{
            wishlistCallback?(.district, indexPath.row)
        }
        else if wishlistType == .package{
            wishlistCallback?(.package, indexPath.row)
        }
        else if wishlistType == .product{
            wishlistCallback?(.product, indexPath.row)
        }
        else if wishlistType == .event{
            wishlistCallback?(.event, indexPath.row)
        }
        else if wishlistType == .blog{
            wishlistCallback?(.blog, indexPath.row)
        }
    }
}

extension WishlistTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
}
