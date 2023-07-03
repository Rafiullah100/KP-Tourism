//
//  WishlistViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/8/22.
//

import UIKit
import SVProgressHUD
class WishlistViewController: UIViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: WishlistTableViewCell.cellReuseIdentifier())
        }
    }
    
    var dispatchGroup: DispatchGroup?
    var postWishlist: [PostWishlistModel]?
    var attractionWishlist: [AttractionWishlistModel]?
    var districtWishlist: [DistrictWishlistModel]?
    var packageWishlist: [PackageWishlistModel]?
    var productWishlist: [ProductWishlistModel]?
    var eventWishlist: [EventWishlistModel]?
    var blogWishlist: [BlogWishlistModel]?

    var type: wishlistSection?
    var wishlistTypeArray: [wishlistSection]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        wishlistTypeArray = wishlistSection.allCases
        dispatchGroup = DispatchGroup()
        dispatchGroup?.enter()
        fetch(route: .wishlist, method: .post, parameters: ["section": wishlistSection.post.rawValue], model: PostSectionModel.self, type: .post)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .wishlist, method: .post, parameters: ["section": wishlistSection.attraction.rawValue], model: AttractionSectionModel.self, type: .attraction)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .wishlist, method: .post, parameters: ["section": wishlistSection.district.rawValue], model: DistrictSectionModel.self, type: .district)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .wishlist, method: .post, parameters: ["section": wishlistSection.package.rawValue], model: PackageSectionModel.self, type: .package)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .wishlist, method: .post, parameters: ["section": wishlistSection.product.rawValue], model: ProductSectionModel.self, type: .product)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .wishlist, method: .post, parameters: ["section": wishlistSection.event.rawValue], model: EventSectionModel.self, type: .event)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .wishlist, method: .post, parameters: ["section": wishlistSection.blog.rawValue], model: BlogSectionModel.self, type: .blog)
        dispatchGroup?.leave()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, type: wishlistSection) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                if type == .post {
                    let wishlist = model as? PostSectionModel
                    self.postWishlist = wishlist?.wishlist
//                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                }
                else if type == .attraction{
                    let wishlist = model as? AttractionSectionModel
                    self.attractionWishlist = wishlist?.wishlist
//                    self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
                }
                else if type == .district{
                    let wishlist = model as? DistrictSectionModel
                    self.districtWishlist = wishlist?.wishlist
//                    self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
                }
                else if type == .package{
                    let wishlist = model as? PackageSectionModel
                    self.packageWishlist = wishlist?.wishlist
//                    self.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
                }
                else if type == .product{
                    let wishlist = model as? ProductSectionModel
                    self.productWishlist = wishlist?.wishlist
//                    self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
                }
                else if type == .event{
                    let wishlist = model as? EventSectionModel
                    self.eventWishlist = wishlist?.wishlist
//                    self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
                }
                else if type == .blog{
                    let wishlist = model as? BlogSectionModel
                    self.blogWishlist = wishlist?.wishlist
//                    self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
                }
                self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    @IBAction func dismissBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension WishlistViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistTypeArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WishlistTableViewCell = tableView.dequeueReusableCell(withIdentifier: WishlistTableViewCell.cellReuseIdentifier()) as! WishlistTableViewCell
        if indexPath.row == 0{
            cell.wishlistType = .post
            cell.postWishlist = postWishlist
        }
        else if indexPath.row == 1{
            cell.wishlistType = .attraction
            cell.attractionWishlist = attractionWishlist
        }
        else if indexPath.row == 2{
            cell.wishlistType = .district
            cell.districtWishlist = districtWishlist
        }
        else if indexPath.row == 3{
            cell.wishlistType = .package
            cell.packageWishlist = packageWishlist
        }
        else if indexPath.row == 4{
            cell.wishlistType = .product
            cell.productWishlist = productWishlist
        }
        else if indexPath.row == 5{
            cell.wishlistType = .event
            cell.eventWishlist = eventWishlist
        }
        else if indexPath.row == 6{
            cell.wishlistType = .blog
            cell.blogWishlist = blogWishlist
        }
        
        cell.wishlistCallback = { type, index in
            if type == .product{
                Switcher.gotoProductDetail(delegate: self, wishListProduct: self.productWishlist?[index].localProduct, type: .wishlist)
            }
            else if type == .package{
                Switcher.gotoPackageDetail(delegate: self, wishListPackage: self.packageWishlist?[index].tourPackage, type: .wishlist)
            }
            else if type == .post{
                Switcher.gotoPostVC(delegate: self, postType: .view, wishlistfeed: self.postWishlist?[index].post)
            }
            else if type == .attraction{
                Switcher.goToDestination(delegate: self, type: .tourismSpot, wishlistAttraction: self.attractionWishlist?[index].attraction)
            }
            else if type == .district{
                Switcher.goToDestination(delegate: self, type: .district, wishlistDistrict: self.districtWishlist?[index].district)
            }
            else if type == .event{
                Switcher.gotoEventDetail(delegate: self, wishlistEvent: self.eventWishlist?[index].socialEvent, type: .wishlist)
            }
            else if type == .blog{
                Switcher.gotoBlogDetail(delegate: self, wishlistBlogDetail: self.blogWishlist?[index].blog, type: .wishlist)
            }
        }
        
        cell.wishlistDeleteCallback = { type, index in
            if type == .product{
                Utility.showAlert(message: "Do you want to delete product from wishlist?", buttonTitles: ["cancel", "ok"]) { responce in
                    if responce == "ok"{
                        self.deleteFromWishlist(route: .doWishApi, method: .post, parameters: ["section_id": self.productWishlist?[index].localProduct.id ?? 0, "section": "local_product"], model: SuccessModel.self, section: type, index: index)
                    }
                }
            }
            else if type == .package{
                Utility.showAlert(message: "Do you want to delete tour package from wishlist?", buttonTitles: ["cancel", "ok"]) { responce in
                    if responce == "ok"{
                        self.deleteFromWishlist(route: .doWishApi, method: .post, parameters: ["section_id": self.packageWishlist?[index].tourPackage.id ?? 0, "section": "tour_package"], model: SuccessModel.self, section: type, index: index)
                    }
                }
            }
            else if type == .post{
                Utility.showAlert(message: "Do you want to delete post from wishlist?", buttonTitles: ["cancel", "ok"]) { responce in
                    if responce == "ok"{
                        self.deleteFromWishlist(route: .doWishApi, method: .post, parameters: ["section_id": self.postWishlist?[index].post.id ?? 0, "section": "post"], model: SuccessModel.self , section: type, index: index)
                    }
                }
            }
            else if type == .attraction{
                Utility.showAlert(message: "Do you want to delete attraction from wishlist?", buttonTitles: ["cancel", "ok"]) { responce in
                    if responce == "ok"{
                        self.deleteFromWishlist(route: .doWishApi, method: .post, parameters: ["section_id": self.attractionWishlist?[index].attraction.id ?? 0, "section": "attraction"], model: SuccessModel.self, section: type, index: index)
                    }
                }
            }
            else if type == .district{
                Utility.showAlert(message: "Do you want to delete district from wishlist?", buttonTitles: ["cancel", "ok"]) { responce in
                    if responce == "ok"{
                        self.deleteFromWishlist(route: .doWishApi, method: .post, parameters: ["section_id": self.districtWishlist?[index].district.id ?? 0, "section": "district"], model: SuccessModel.self, section: type, index: index)
                    }
                }
            }
            else if type == .event{
                Utility.showAlert(message: "Do you want to delete event from wishlist?", buttonTitles: ["cancel", "ok"]) { responce in
                    if responce == "ok"{
                        self.deleteFromWishlist(route: .doWishApi, method: .post, parameters: ["section_id": self.eventWishlist?[index].socialEventID ?? 0, "section": "social_event"], model: SuccessModel.self, section: type, index: index)
                    }
                }
            }
            else if type == .blog{
                Utility.showAlert(message: "Do you want to delete blog from wishlist?", buttonTitles: ["cancel", "ok"]) { responce in
                    if responce == "ok"{
                        self.deleteFromWishlist(route: .doWishApi, method: .post, parameters: ["section_id": self.blogWishlist?[index].blogID ?? 0, "section": "blog"], model: SuccessModel.self, section: type, index: index)
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func deleteFromWishlist<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, section: wishlistSection, index: Int) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let change):
                let res = change as? SuccessModel
                if res?.success == true{
                    if section == .post{
                        self.postWishlist?.remove(at: index)
                    }
                    else if section == .product{
                        self.productWishlist?.remove(at: index)
                    }
                    else if section == .attraction{
                        self.attractionWishlist?.remove(at: index)
                    }
                    else if section == .district{
                        self.districtWishlist?.remove(at: index)
                    }
                    else if section == .package{
                        self.packageWishlist?.remove(at: index)
                    }
                    else if section == .event{
                        self.eventWishlist?.remove(at: index)
                    }
                    else if section == .blog{
                        self.blogWishlist?.remove(at: index)
                    }
                    self.tableView.reloadData()
                }
                else{
                    self.view.makeToast(res?.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}
