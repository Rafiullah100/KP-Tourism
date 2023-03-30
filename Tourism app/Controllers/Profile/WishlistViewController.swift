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
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, type: wishlistSection) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                if type == .post {
                    let wishlist = model as? PostSectionModel
                    self.postWishlist = wishlist?.wishlist
                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                }
                else if type == .attraction{
                    let wishlist = model as? AttractionSectionModel
                    self.attractionWishlist = wishlist?.wishlist
                    self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
                }
                else if type == .district{
                    let wishlist = model as? DistrictSectionModel
                    self.districtWishlist = wishlist?.wishlist
                    self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
                }
                else if type == .package{
                    let wishlist = model as? PackageSectionModel
                    self.packageWishlist = wishlist?.wishlist
                    self.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
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
            cell.postWishlist = postWishlist
        }
        else if indexPath.row == 1{
            cell.attractionWishlist = attractionWishlist
        }
        else if indexPath.row == 2{
            cell.districtWishlist = districtWishlist
        }
        else{
            cell.packageWishlist = packageWishlist
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
