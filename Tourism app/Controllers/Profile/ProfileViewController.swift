//
//  ProfileViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/7/22.
//

import UIKit
import MaterialComponents.MaterialTabs_TabBarView
import SDWebImage
import SVProgressHUD
class ProfileViewController: UIViewController {

    enum ApiType {
        case profile
        case status
        case blog
        case product
        case post
    }
    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tabbarView: MDCTabBarView!
    @IBOutlet weak var topProfileView: UIView!
    
    @IBOutlet weak var statusCollectionView: UICollectionView!{
        didSet{
//            statusCollectionView.dataSource = self
//            statusCollectionView.delegate = self
            statusCollectionView.register(UINib(nibName: "StatusCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StatusCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    var dispatchGroup: DispatchGroup?

    
    @IBOutlet weak var contentCollectionView: UICollectionView!{
        didSet{
            contentCollectionView.dataSource = self
            contentCollectionView.delegate = self
            contentCollectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.cellReuseIdentifier())
        }
    }

    var tabbarItems = [UITabBarItem]()
    var userProfile: ProfileModel?
    var profileSection: ProfileSection!
    var post: [UserPostRow]?
    var blogs: [UserBlogRow]?
    var products: [UserProductRow]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        topProfileView.layer.shadowColor = UIColor.black.cgColor
        topProfileView.layer.shadowOpacity = 1
        topProfileView.layer.shadowOffset = .zero
        topProfileView.layer.shadowRadius = 10
        topProfileView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 30.0)
        configureTabbar()
    }
    
    private func configureTabbar(){
        let section = ["Blogs", "Products", "Post"]
        for i in 0..<section.count{
            let tabbarItem = UITabBarItem(title: section[i], image: nil, tag: i)
            tabbarItems.append(tabbarItem)
        }
        profileSection = .blog
        tabbarView.items = tabbarItems
        tabbarView.selectedItem = tabbarView.items[0]
        tabbarView.bottomDividerColor = .clear
        tabbarView.rippleColor = .clear
        tabbarView.selectionIndicatorStrokeColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
        tabbarView.preferredLayoutStyle = .scrollableCentered
        tabbarView.isScrollEnabled = false
        tabbarView.tabBarDelegate = self
        tabbarView.setTitleFont(UIFont(name: "Poppins-Medium", size: 15.0), for: .normal)
        tabbarView.setTitleFont(UIFont(name: "Poppins-Medium", size: 15.0), for: .selected)
        tabbarView.setTitleColor(.lightGray, for: .normal)
        tabbarView.setTitleColor(.black, for: .selected)
        tabbarView.minItemWidth = 100.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func followerBtnAction(_ sender: Any) {
        Switcher.showFollower(delegate: self)
    }
    @IBAction func settingBtnAction(_ sender: Any) {
        Switcher.goToSettingVC(delegate: self)
    }
    @IBAction func favoriteBtnAction(_ sender: Any) {
        Switcher.goToWishlistVC(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let uuid = UserDefaults.standard.uuid else { return  }
        dispatchGroup?.enter()
        fetch(route: .fetchProfile, method: .post, parameters: ["uuid": uuid], model: ProfileModel.self, apiType: .profile)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .userBlog, method: .post, parameters: ["uuid": uuid], model: UserBlogModel.self, apiType: .blog)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .userProduct, method: .post, parameters: ["uuid": uuid], model: UserProductModel.self, apiType: .product)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .userPost, method: .post, parameters: ["uuid": uuid], model: UserPostModel.self, apiType: .post)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, apiType: ApiType) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                if apiType == .profile{
                    self.userProfile = model as? ProfileModel
                    self.profileImageView.sd_setImage(with: URL(string: Route.baseUrl + (self.userProfile?.userDetails.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
                    self.nameLabel.text = self.userProfile?.userDetails.name
                    self.postCountLabel.text = "\(self.userProfile?.userDetails.postsCount ?? 0)"
                    self.followerCountLabel.text = "\(self.userProfile?.userDetails.userFollowers ?? 0)"
                    self.followingCountLabel.text = "\(self.userProfile?.userDetails.userFollowings ?? 0)"
                }
                else if apiType == .blog{
                    self.blogs = (model as? UserBlogModel)?.blogs.rows
                    self.blogs?.count == 0 ? self.contentCollectionView.setEmptyView() : self.contentCollectionView.reloadData()
                }
                else if apiType == .product{
                    self.products = (model as? UserProductModel)?.localProducts.rows
                }
                else if apiType == .post{
                    self.post = (model as? UserPostModel)?.posts.rows
                }
                
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case statusCollectionView:
            return 20
        case contentCollectionView:
            return noOfRows()
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case statusCollectionView:
            let cell: StatusCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! StatusCollectionViewCell
            cell.cellType = indexPath.row == 0 ? .userSelf : .other
            return cell
        case contentCollectionView:
            let cell: ProfileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! ProfileCollectionViewCell
            loadCollection(cell: cell, indexPath: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    private func noOfRows() -> Int{
        switch profileSection {
        case .post:
            return post?.count ?? 0
        case .blog:
            return blogs?.count ?? 0
        case .product:
            return products?.count ?? 0
        default:
            return 0
        }
    }

   private func loadCollection(cell:ProfileCollectionViewCell, indexPath: IndexPath) {
        switch profileSection {
        case .post:
            cell.post = post?[indexPath.row]
        case .product:
            cell.product = products?[indexPath.row]
        case .blog:
            cell.blog = blogs?[indexPath.row]
        default:
            break
        }
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case statusCollectionView:
            return CGSize(width: 80, height: 110)
        case contentCollectionView:
            let cellsAcross: CGFloat = 3
            let spaceBetweenCells: CGFloat = 2
            let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
            return CGSize(width: width, height: width)
        default:
            return CGSize.zero
        }
    }
}

extension ProfileViewController: MDCTabBarViewDelegate{
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
        print(item.tag)
        if item.tag == 0{
//            contentCollectionView.backgroundView = self.blogs?.count == 0 ? contentCollectionView.setEmptyView() : UIView()
            profileSection = .blog
        }
        else if item.tag == 1{
//            contentCollectionView.backgroundView = self.products?.count == 0 ? contentCollectionView.setEmptyView() : UIView()
            profileSection = .product
        }
        else if item.tag == 2{
//            contentCollectionView.backgroundView = self.post?.count == 0 ? contentCollectionView.setEmptyView() : UIView()
            profileSection = .post
        }
        contentCollectionView.reloadData()
    }
}
