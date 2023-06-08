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
        case delete
        case tourPackage
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
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var editPhotoButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var addButton: UIView!
    
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
    
    var tourPackages: [UserProfileTourPackages]?
    
    var profileType: ProfileType?
    var uuid: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        topProfileView.clipsToBounds = false
        topProfileView.layer.masksToBounds = false
        topProfileView.layer.cornerRadius = 30
        topProfileView.viewShadow()
        addButton.isHidden = profileType == .user ? false : true
        writeBlogButton.isHidden = profileType == .user ? false : true
        buttonsView.isUserInteractionEnabled = profileType == .user ? true : false

        navigationController?.navigationBar.isHidden = true
        print(uuid ?? "")
        dispatchGroup?.enter()
        fetch(route: .fetchProfile, method: .post, parameters: ["uuid": uuid ?? ""], model: ProfileModel.self, apiType: .profile)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        storyApiCall()
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .userBlog, method: .post, parameters: ["uuid": uuid ?? ""], model: UserBlogModel.self, apiType: .blog)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        if Helper.shared.isSeller() {
            fetch(route: .userProduct, method: .post, parameters: ["uuid": uuid ?? ""], model: UserProductModel.self, apiType: .product)
        }
        else{
            fetch(route: .userTourPackage, method: .post, model: ProfileTourPackage.self, apiType: .tourPackage)
        }
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        postApiCall()
        dispatchGroup?.leave()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if profileType == .otherUser{
            settingButton.setImage(UIImage(named: "arrow-back"), for: .normal)
            favoriteButton.isHidden = true
            editPhotoButton.isHidden = false
        }
        else{
            settingButton.setImage(UIImage(named: "setting-btn-icon"), for: .normal)
            favoriteButton.isHidden = false
            editPhotoButton.isHidden = true
        }
    }
    
    private func configureTabbar(){
        var tag = 0
        var user: [Sections] = []
        if Helper.shared.isSeller()  {
            user = Constants.sellerUser
        }
        else if Helper.shared.isTourist() {
            user = Constants.touristUser
        }
        else{
            user = Constants.sampleUser
        }
        
        for item in user {
            let tabbarItem = UITabBarItem(title: item.title, image: UIImage(named: item.image), tag: tag)
            tag = tag + 1
            tabbarItems.append(tabbarItem)
        }
        profileSection = .post
        tabbarView.tabBarDelegate = self
        tabbarView.delegate = self
        Helper.shared.customTab(tabbar: tabbarView, items: tabbarItems)
        tabbarView.backgroundColor = .clear
        tabbarView.setTitleFont(UIFont(name: "Poppins-Light", size: 15), for: .normal)
        tabbarView.setTitleFont(UIFont(name: "Poppins-Medium", size: 15), for: .selected)
        tabbarView.bottomDividerColor = .clear
        tabbarView.minItemWidth = (view.bounds.width - 100) / CGFloat(tabbarItems.count)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tabbarView {
            Helper.shared.disableVerticalScrolling(tabbarView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func followBtnAction(_ sender: Any) {
        followUser(route: .doFollow, method: .post, parameters: ["uuid": uuid ?? ""], model: SuccessModel.self)
    }
    
    func followUser<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let success):
                let res = success as? SuccessModel
                SVProgressHUD.showSuccess(withStatus: res?.message)
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func followingBtnAction(_ sender: Any) {
        guard let profileType = profileType else { return }
        Switcher.showFollower(delegate: self, profileType: profileType, connectionType: .following)
    }
    
    @IBAction func followerBtnAction(_ sender: Any) {
        guard let profileType = profileType else { return }
        Switcher.showFollower(delegate: self, profileType: profileType, connectionType: .follower)
    }
    @IBAction func settingBtnAction(_ sender: Any) {
        if profileType == .otherUser{
            navigationController?.popViewController(animated: true)
        }
        else{
            Switcher.goToSettingVC(delegate: self)
        }
    }
    @IBAction func favoriteBtnAction(_ sender: Any) {
        Switcher.goToWishlistVC(delegate: self)
    }
    
    @IBAction func writeBlogBtnAction(_ sender: Any) {
        if profileSection == .blog{
            Switcher.gotoWriteBlogVC(delegate: self, postType: .post)
        }
        else if profileSection == .product{
            if Helper.shared.isSeller() {
                Switcher.gotoAddProductVC(delegate: self, postType: .post)
            }
            else{
                Switcher.gotoAddTourVC(delegate: self, postType: .post)
            }
        }
    }
    
    
    @IBAction func suggestedUserBtn(_ sender: Any) {
        Switcher.showSuggestedUser(delegate: self)
    }
    
    private func storyApiCall(){
        fetch(route: .userStories, method: .post, parameters: ["uuid": uuid ?? "", "limit": limit, "page": storyCurrentPage], model: FeedStoriesModel.self, apiType: .story)
    }
    
    private func postApiCall(){
        fetch(route: .userPost, method: .post, parameters: ["uuid": uuid ?? "", "limit": limit, "page": postCurrentPage], model: UserPostModel.self, apiType: .post)
    }
    
    private func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, apiType: ApiType, index: Int? = nil) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                if apiType == .profile{
                    self.userProfile = model as? ProfileModel
                    if self.profileType == .user{
                        self.profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
                    }
                    else{
                        self.profileImageView.sd_setImage(with: URL(string: Route.baseUrl + (self.userProfile?.userDetails.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
                    }
                    self.bioLabel.text = self.userProfile?.userDetails.about
                    self.nameLabel.attributedText = Helper.shared.attributedString(text1: self.userProfile?.userDetails.name?.capitalized ?? "", text2: "(\(self.userProfile?.userDetails.userType ?? ""))")
                    self.postCountLabel.text = "\(self.userProfile?.userDetails.postsCount ?? 0)"
                    self.followerCountLabel.text = "\(self.userProfile?.userDetails.userFollowers ?? 0)"
                    self.followingCountLabel.text = "\(self.userProfile?.userDetails.userFollowings ?? 0)"
                    UserDefaults.standard.userType = self.userProfile?.userDetails.userType
                    UserDefaults.standard.isSeller = self.userProfile?.userDetails.isSeller
                    UserDefaults.standard.isTourist = self.userProfile?.userDetails.isTourist
                    self.configureTabbar()
                }
                else if apiType == .story{
                    self.stories.append(contentsOf: (model as? FeedStoriesModel)?.stories?.rows ?? [])
                    self.storyTotalCount = (model as? FeedStoriesModel)?.stories?.count ?? 0
                    print(self.storyTotalCount)
                    self.statusCollectionView.reloadData()
                    self.statusView.isHidden = self.storyTotalCount == 0 ? true : false
                }
                else if apiType == .post{
                    self.post.append(contentsOf: (model as? UserPostModel)?.posts?.rows ?? [])
                    self.postTotalCount = (model as? UserPostModel)?.posts?.count ?? 0
                    self.postTotalCount == 0 ? self.contentCollectionView.setEmptyView("No Post found!") : self.contentCollectionView.reloadData()
                }
                else if apiType == .product{
                    self.products = (model as? UserProductModel)?.localProducts?.rows
                }
                else if apiType == .blog{
                    self.blogs = (model as? UserBlogModel)?.blogs?.rows
                }
                else if apiType == .tourPackage{
                    self.tourPackages = (model as? ProfileTourPackage)?.userTourPackages
                }
                else if apiType == .delete{
                    let successModel = model as? SuccessModel
                    if successModel?.success == true{
                        if self.profileSection == .blog{
                            self.blogs?.remove(at: index ?? 0)
                            self.contentCollectionView.reloadData()
                        }
                        else if self.profileSection == .product{
                            if Helper.shared.isSeller() {
                                self.products?.remove(at: index ?? 0)
                                self.contentCollectionView.reloadData()
                            }
                            else{
                                self.tourPackages?.remove(at: index ?? 0)
                                self.contentCollectionView.reloadData()
                            }
                        }
                        self.view.makeToast(successModel?.message)
                    }
                }
                self.contentCollectionView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
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
                cell.imgView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()))
            }
            else{
                cell.stories = stories[indexPath.row - 1]
            }
            return cell
        case contentCollectionView:
            let cell: ProfileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! ProfileCollectionViewCell
            cell.profileType = profileType
            cell.sectionType = profileSection
            loadCollection(cell: cell, indexPath: indexPath)
            
            cell.editActionBlock = {
                if self.profileSection == .blog{
                    Switcher.gotoWriteBlogVC(delegate: self, blog: self.blogs?[indexPath.row], postType: .edit)
                }
                else if self.profileSection == .product{
                    if Helper.shared.isSeller() {
                        Switcher.gotoAddProductVC(delegate: self, product: self.products?[indexPath.row], postType: .edit)
                    }
                    else if Helper.shared.isTourist() {
                        Switcher.gotoAddTourVC(delegate: self, tourPackage: self.tourPackages?[indexPath.row], postType: .edit)
                    }
                }
            }
            
            cell.deleteActionBlock = {
                Utility.showAlert(message: "Do you want to delete?", buttonTitles: ["No", "Yes"]) { responce in
                    if responce == "Yes"{
                        var id = 0
                        var section = ""
                        if self.profileSection == .blog{
                            section = "blog"
                            id = self.blogs?[indexPath.row].id ?? 0
                        }
                        else {
                            if Helper.shared.isSeller() {
                                section = "local_product"
                                id = self.products?[indexPath.row].id ?? 0
                            }
                            else if Helper.shared.isTourist() {
                                section = "tour_package"
                                id = self.tourPackages?[indexPath.row].id ?? 0
                            }
                        }
                        self.fetch(route: .deleteApi, method: .post, parameters: ["section": section,  "id": id], model: SuccessModel.self, apiType: .delete, index: indexPath.row)
                    }
                }
            }
            return cell
        default: return UICollectionViewCell()
        }
    }

    private func noOfRows() -> Int{
        switch profileSection {
        case .post:
            return post.count
        case .blog:
            return blogs?.count ?? 0
        case .product:
            let count = Helper.shared.isSeller() == true ? products?.count : tourPackages?.count
            return count ?? 0
        default: return 0
        }
    }

   private func loadCollection(cell:ProfileCollectionViewCell, indexPath: IndexPath) {
       contentCollectionView.backgroundView = nil
        switch profileSection {
        case .post:
            post.count == 0 ? contentCollectionView.setEmptyView() : nil
            cell.post = post[indexPath.row]
        case .product:
            products?.count == 0 ? contentCollectionView.setEmptyView() : nil
            if Helper.shared.isSeller() {
                cell.product = products?[indexPath.row]
            }
            else{
                cell.tourPackage = tourPackages?[indexPath.row]
            }
        case .blog:
            blogs?.count == 0 ? contentCollectionView.setEmptyView() : nil
            cell.blog = blogs?[indexPath.row]
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == statusCollectionView{
            if stories.count != storyTotalCount && indexPath.row == stories.count {
                storyCurrentPage = storyCurrentPage + 1
                storyApiCall()
            }
        }
        else{
            if profileSection == .post{
                if post.count != postTotalCount && indexPath.row == post.count - 1{
                    postCurrentPage = postCurrentPage + 1
                    postApiCall()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0{
            Switcher.gotoViewerVC(delegate: self, position: 0, type: .image, imageUrl: stories[indexPath.row - 1].postFiles?[0].imageURL)
        }
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case statusCollectionView:
            return CGSize(width: 80, height: 110)
        case contentCollectionView:
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
            addButton.isHidden = true
            profileSection = .post
            self.post.count == 0 ? self.contentCollectionView.setEmptyView("No Post found!") : self.contentCollectionView.reloadData()
        }
        else if item.tag == 1{
            addButton.isHidden = false
            writeBlogButton.setBackgroundImage(UIImage(named: "write-blog"), for: .normal)
            profileSection = .blog
            self.blogs?.count == 0 ? self.contentCollectionView.setEmptyView("No blog found!") : self.contentCollectionView.reloadData()
        }
        else if item.tag == 2{
            addButton.isHidden = false
            writeBlogButton.setBackgroundImage(UIImage(named: "add-product"), for: .normal)
            profileSection = .product
            if Helper.shared.isSeller() {
                self.products?.count == 0 ? self.contentCollectionView.setEmptyView("No Product found!") : self.contentCollectionView.reloadData()
            }
            else if Helper.shared.isTourist() {
                self.tourPackages?.count == 0 ? self.contentCollectionView.setEmptyView("No Tour Package found!") : self.contentCollectionView.reloadData()
            }
        }
        contentCollectionView.reloadData()
    }
}
