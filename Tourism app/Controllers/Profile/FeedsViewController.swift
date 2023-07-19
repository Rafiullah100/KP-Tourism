//
//  FeedsViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/5/22.
//

import UIKit
import ExpandableLabel
import Toast_Swift
import SVProgressHUD
class FeedsViewController: BaseViewController {
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "StatusCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StatusCollectionViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: FeedTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var newsFeed: [FeedModel] = [FeedModel]()
//    var stories: [StoriesRow]?
    var states : Array<Bool>!
    let pickerView = UIPickerView()
    var numberOfCells : NSInteger = 0
    var stories: [StoriesRow]   = [StoriesRow]()

    let setting = ["edit", "delete"]
    var dispatchGroup: DispatchGroup?

    var totalCount = 0
    var currentPage = 1
    var limit = 5
    var storyLimit = 5

    var storyTotalCount = 1
    var storyCurrentPage = 1
    var interestCount = 0
    let refreshControl = UIRefreshControl()
    var profileType: ProfileType?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        topBarView.addBottomShadow()
        pickerView.delegate = self
        pickerView.dataSource = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNewsFeed), name: NSNotification.Name(rawValue: Constants.loadFeed), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadStories), name: NSNotification.Name(rawValue: Constants.loadFeed), object: nil)
        
        loadData()
        profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()))
        profileButton.sd_setBackgroundImage(with: URL(string: Helper.shared.getProfileImage()), for: .normal)
        
        refreshControl.addTarget(self, action: #selector(reloadNewsFeed), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @IBAction func postBtnAction(_ sender: Any) {
        Switcher.gotoPostVC(delegate: self, postType: .post)
    }
    
    @IBAction func chatBtnAction(_ sender: Any) {
        Switcher.goToChatListVC(delegate: self)
    }
    
    @IBAction func profileBtnAction(_ sender: Any) {
        guard let uuid = UserDefaults.standard.uuid else { return }
        Switcher.goToProfileVC(delegate: self, profileType: .user, uuid: uuid)
    }
    
    func loadData(){
        dispatchGroup = DispatchGroup()
        dispatchGroup?.enter()
        storyApiCall()
        self.dispatchGroup?.leave()
        dispatchGroup?.enter()
        loadNewsFeed()
        self.dispatchGroup?.leave()
    }
    
    func loadNewsFeed(){
        fetchFeeds(parameters: ["page": currentPage, "limit": limit, "token": UserDefaults.standard.accessToken ?? ""])
    }
    
    @objc func reloadStories(){
        stories = []
        storyTotalCount = 0
        storyCurrentPage = 1
        fetchFeedsStories(parameters: ["page": currentPage, "limit": storyLimit, "token": UserDefaults.standard.accessToken ?? ""])
    }
    
    @objc func reloadNewsFeed(){
        newsFeed = []
        totalCount = 0
        currentPage = 1
        loadNewsFeed()
        refreshControl.endRefreshing()
    }
    
    @objc func storyApiCall(){
        fetchFeedsStories(parameters: ["page": currentPage, "limit": storyLimit, "token": UserDefaults.standard.accessToken ?? ""])
    }
    
    func fetchFeeds(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchFeeds, method: .post, showLoader: false, parameters: parameters, model: NewsFeedModel.self) { result in
            switch result {
            case .success(let feedsModel):
                self.newsFeed.append(contentsOf: feedsModel.feeds ?? [])
                self.totalCount = feedsModel.count ?? 0
                self.numberOfCells = self.totalCount
                self.states = [Bool](repeating: true, count: self.numberOfCells)
                self.newsFeed.count == 0 ? self.tableView.setEmptyView("No Feeds to show!") : self.tableView.setEmptyView("")
                self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func fetchFeedsStories(parameters: [String: Any]) {
        URLSession.shared.request(route: .feedStories, method: .post, parameters: parameters, model: FeedStoriesModel.self) { result in
            switch result {
            case .success(let feedStories):
                self.stories.append(contentsOf: feedStories.stories?.rows ?? [])
                self.storyTotalCount = feedStories.stories?.count ?? 0
                print(self.storyTotalCount)
                self.storyTotalCount == 0 ? self.collectionView.setEmptyView("") : self.collectionView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    
    private func actionSheet(row: Int){
        var buttonTitles: [String]?
//        if newsFeed[row].action == "created" {
            buttonTitles = ["Edit", "Delete", "Cancel"]
//        }
//        else{
//            buttonTitles = ["Delete", "Cancel"]
//        }
        Utility.actionSheet(message: "choose action", buttonTitles: buttonTitles ?? []) { responce in
            if responce == "Edit"{
                Switcher.gotoPostVC(delegate: self, postType: .edit, feed: self.newsFeed[row])
            }
            else if responce == "Delete"{
                Utility.showAlert(message: "Are you sure you want to delete?", buttonTitles: ["No", "Yes"]) { responce in
                    if responce == "Yes"{
                        self.deletePost(parameters: ["id": self.newsFeed[row].id ?? 0], row: row)
                    }
                }
            }
        }
    }
    
    func deletePost(parameters: [String: Any]? = nil, row: Int) {
        URLSession.shared.request(route: .deletePost, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let delete):
                if delete.success == true{
                    self.newsFeed.remove(at: row)
                    self.tableView.reloadData()
                    self.view.makeToast(delete.message)
                }
                else{
                    self.view.makeToast(delete.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    func share(parameters: [String: Any]) {
        URLSession.shared.request(route: .shareApi, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let share):
                if share.success == true{
                    self.view.makeToast("Post shared successfully.")
                }
                else{
                    self.view.makeToast(share.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func toggleLikeStatus(for indexPath: IndexPath) {
        var feed = newsFeed[indexPath.row]
        feed.isLiked = feed.isLiked == 1 ? 0 : 1
        feed.likesCount = feed.isLiked == 1 ? (feed.likesCount ?? 0) + 1 : (feed.likesCount ?? 0) - 1
        newsFeed[indexPath.row] = feed
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func toggleWishlistStatus(for indexPath: IndexPath) {
        var feed = newsFeed[indexPath.row]
        feed.isWished = feed.isWished == 1 ? 0 : 1
        newsFeed[indexPath.row] = feed
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension FeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StatusCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! StatusCollectionViewCell
        cell.cellType = indexPath.row == 0 ? .userSelf : .other
        if indexPath.row == 0 {
            cell.imgView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()))
        }
        else{
            cell.stories = stories[indexPath.row - 1]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            Switcher.gotoPostVC(delegate: self, postType: .story)
        }
        else{
            Switcher.gotoStatusVC(delegate: self, url: stories[indexPath.row - 1].postFiles?[0].imageURL ?? "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(stories.count, storyTotalCount, indexPath.row)
        if stories.count != storyTotalCount && indexPath.row == stories.count - 1 {
            storyCurrentPage = storyCurrentPage + 1
            storyApiCall()
        }
    }
}

extension FeedsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
}

extension FeedsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellReuseIdentifier(), for: indexPath) as! FeedTableViewCell
        cell.layoutIfNeeded()
        cell.expandableLabel.delegate = self
        cell.actionBlock = {
            self.actionSheet(row: indexPath.row)
        }
        cell.likeButtonTappedHandler = {
            self.toggleLikeStatus(for: indexPath)
        }
        cell.wishlistButtonTappedHandler = {
            self.toggleWishlistStatus(for: indexPath)
        }
        print(newsFeed.count)
        cell.configure(feed: newsFeed[indexPath.row])
        cell.shareActionBlock = {
            Utility.showAlert(message: "Do you want to share the post?", buttonTitles: ["No", "Yes"]) { responce in
                if responce == "Yes"{
                    self.share(parameters: ["post_id": self.newsFeed[indexPath.row].post_id ?? 0])
                }
            }
        }
        cell.commentActionBlock = {
            Switcher.gotoPostCommentVC(delegate: self, postId: self.newsFeed[indexPath.row].id ?? 0)
        }
        cell.profileImageActionBlock = {
            guard let uuid = self.newsFeed[indexPath.row].post?.users?.uuid else { return }
            self.profileType = UserDefaults.standard.uuid == uuid ? .user : .otherUser
            print(uuid)
            Switcher.goToProfileVC(delegate: self, profileType: self.profileType ?? .user, uuid: uuid)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if newsFeed.count != totalCount && indexPath.row == newsFeed.count - 1  {
            currentPage = currentPage + 1
            loadNewsFeed()
        }
    }
}

extension FeedsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return setting.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return setting[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected")
    }
}





