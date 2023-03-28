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

   private enum ApiType {
        case profile
        case story
        case blog
        case product
        case post
    }
    
    @IBOutlet weak var bottomView: UIView!
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
    
    @IBOutlet weak var writeBlogButton: UIButton!
    @IBOutlet weak var statusCollectionView: UICollectionView!{
        didSet{
            statusCollectionView.dataSource = self
            statusCollectionView.delegate = self
            statusCollectionView.register(UINib(nibName: "StatusCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StatusCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    var dispatchGroup: DispatchGroup?
    var postTotalCount = 1
    var postCurrentPage = 1
    var limit = 5
    
    var storyTotalCount = 1
    var storyCurrentPage = 1
    
    @IBOutlet weak var contentCollectionView: UICollectionView!{
        didSet{
            contentCollectionView.dataSource = self
            contentCollectionView.delegate = self
            contentCollectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var bioLabel: UILabel!
    
    var tabbarItems = [UITabBarItem]()
    var userProfile: ProfileModel?
    var profileSection: ProfileSection!
    var post: [UserPostRow] = [UserPostRow]()
    var blogs: [UserBlogRow]?
    var products: [UserProductRow]?
    var stories: [StoriesRow]   = [StoriesRow]()

    override func viewDidLoad() {
        super.viewDidLoad()
        topProfileView.clipsToBounds = true
        topProfileView.layer.masksToBounds = true
        topProfileView.layer.cornerRadius = 30
        topProfileView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        configureTabbar()
//        topProfileView.addBottomShadow()
    }
    
    private func configureTabbar(){
        let section = ["Post", "Products", "Blogs"]
        for i in 0..<section.count{
            let tabbarItem = UITabBarItem(title: section[i], image: nil, tag: i)
            tabbarItems.append(tabbarItem)
        }
        profileSection = .post
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
    @IBAction func followingBtnAction(_ sender: Any) {
        Switcher.showFollower(delegate: self)
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
    
    @IBAction func writeBlogBtnAction(_ sender: Any) {
        if profileSection == .blog{
            Switcher.gotoWriteBlogVC(delegate: self)
        }
        else if profileSection == .product{
            Switcher.gotoAddProductVC(delegate: self)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let uuid = UserDefaults.standard.uuid else { return  }
        dispatchGroup?.enter()
        fetch(route: .fetchProfile, method: .post, parameters: ["uuid": uuid], model: ProfileModel.self, apiType: .profile)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        storyApiCall()
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .userBlog, method: .post, parameters: ["uuid": uuid], model: UserBlogModel.self, apiType: .blog)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .userProduct, method: .post, parameters: ["uuid": uuid], model: UserProductModel.self, apiType: .product)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        postApiCall()
        dispatchGroup?.leave()
    }
    
    private func storyApiCall(){
        guard let uuid = UserDefaults.standard.uuid else { return  }
        fetch(route: .userStories, method: .post, parameters: ["uuid": uuid, "limit": limit, "page": storyCurrentPage], model: FeedStoriesModel.self, apiType: .story)
    }
    
    private func postApiCall(){
        guard let uuid = UserDefaults.standard.uuid else { return  }
        fetch(route: .userPost, method: .post, parameters: ["uuid": uuid, "limit": limit, "page": postCurrentPage], model: UserPostModel.self, apiType: .post)
    }
    
   private func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, apiType: ApiType) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                if apiType == .profile{
                    self.userProfile = model as? ProfileModel
                    self.profileImageView.sd_setImage(with: URL(string: Route.baseUrl + (self.userProfile?.userDetails.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
                    self.bioLabel.text = self.userProfile?.userDetails.about
                    self.nameLabel.text = self.userProfile?.userDetails.name
                    self.postCountLabel.text = "\(self.userProfile?.userDetails.postsCount ?? 0)"
                    self.followerCountLabel.text = "\(self.userProfile?.userDetails.userFollowers ?? 0)"
                    self.followingCountLabel.text = "\(self.userProfile?.userDetails.userFollowings ?? 0)"
                    UserDefaults.standard.userType = self.userProfile?.userDetails.userType
                }
                else if apiType == .story{
                    self.stories.append(contentsOf: (model as? FeedStoriesModel)?.stories?.rows ?? [])
                    self.storyTotalCount = (model as? FeedStoriesModel)?.stories?.count ?? 0
                    self.statusCollectionView.reloadData()
                    self.statusView.isHidden = self.storyTotalCount == 0 ? true : false
                }
                else if apiType == .post{
                    self.post.append(contentsOf: (model as? UserPostModel)?.posts?.rows ?? [])
                    self.postTotalCount = (model as? UserPostModel)?.posts?.count ?? 0
                    self.post.count == 0 ? self.contentCollectionView.setEmptyView() : self.contentCollectionView.reloadData()
                }
                else if apiType == .product{
                    self.products = (model as? UserProductModel)?.localProducts?.rows
                    self.products?.count == 0 ? self.contentCollectionView.setEmptyView() : self.contentCollectionView.reloadData()
                }
                else if apiType == .blog{
                    self.blogs = (model as? UserBlogModel)?.blogs?.rows
                    self.blogs?.count == 0 ? self.contentCollectionView.setEmptyView() : self.contentCollectionView.reloadData()
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
            return stories.count + 1
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
            if indexPath.row == 0 {
                cell.imgView.image = UIImage(named: "placeholder")
            }
            else{
                cell.stories = stories[indexPath.row - 1]
            }
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
            return post.count
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
            cell.post = post[indexPath.row]
        case .product:
            cell.product = products?[indexPath.row]
        case .blog:
            cell.blog = blogs?[indexPath.row]
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == statusCollectionView{
            print(indexPath.row, stories.count)
            if stories.count != postTotalCount && indexPath.row == stories.count {
                storyCurrentPage = storyCurrentPage + 1
                print("current page \(postCurrentPage)")
                storyApiCall()
            }
        }
        else{
            if profileSection == .post{
                if post.count != postTotalCount && indexPath.row == post.count - 1{
                    postCurrentPage = postCurrentPage + 1
                    print("current page \(postCurrentPage)")
                    postApiCall()
                }
            }
        }
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case statusCollectionView:
            return CGSize(width: 80, height: 110)
        case contentCollectionView:
//            Helper.shared.cellSize(collectionView: contentCollectionView, space: 2, cellsAcross: 2)
            let cellsAcross: CGFloat = 2
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
            writeBlogButton.isHidden = true
            profileSection = .post
            self.post.count == 0 ? self.contentCollectionView.setEmptyView() : self.contentCollectionView.reloadData()
        }
        else if item.tag == 1{
            writeBlogButton.isHidden = false
            writeBlogButton.setBackgroundImage(UIImage(named: "add-product"), for: .normal)
            profileSection = .product
            self.products?.count == 0 ? self.contentCollectionView.setEmptyView() : self.contentCollectionView.reloadData()
        }
        else if item.tag == 2{
            writeBlogButton.isHidden = false
            writeBlogButton.setBackgroundImage(UIImage(named: "write-blog"), for: .normal)
            profileSection = .blog
            self.blogs?.count == 0 ? self.contentCollectionView.setEmptyView() : self.contentCollectionView.reloadData()
        }
        contentCollectionView.reloadData()
    }
}
