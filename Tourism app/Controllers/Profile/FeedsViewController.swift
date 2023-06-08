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
class FeedsViewController: UIViewController {
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
        fetchFeeds(route: .fetchFeeds, method: .post, parameters: ["page": currentPage, "limit": limit, "token": UserDefaults.standard.accessToken ?? ""], model: NewsFeedModel.self)
    }
    
    @objc func reloadStories(){
        stories = []
        storyTotalCount = 0
        storyCurrentPage = 1
        fetchFeedsStories(route: .feedStories, method: .post, parameters: ["page": currentPage, "limit": storyLimit, "token": UserDefaults.standard.accessToken ?? ""], model: FeedStoriesModel.self)
    }
    
    @objc func reloadNewsFeed(){
        newsFeed = []
        totalCount = 0
        currentPage = 1
        fetchFeeds(route: .fetchFeeds, method: .post, parameters: ["page": currentPage, "limit": limit, "token": UserDefaults.standard.accessToken ?? ""], model: NewsFeedModel.self)
    }
    
    @objc func storyApiCall(){
        fetchFeedsStories(route: .feedStories, method: .post, parameters: ["page": currentPage, "limit": storyLimit, "token": UserDefaults.standard.accessToken ?? ""], model: FeedStoriesModel.self)
    }
    
    func fetchFeeds<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let feeds):
                self.newsFeed.append(contentsOf: (feeds as? NewsFeedModel)?.feeds ?? [])
                self.totalCount = (feeds as! NewsFeedModel).count ?? 0
                self.numberOfCells = self.totalCount
                self.states = [Bool](repeating: true, count: self.numberOfCells)
                self.newsFeed.count == 0 ? self.tableView.setEmptyView("No Feeds to show!") : self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func fetchFeedsStories<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let feedStories):
                let model = feedStories as? FeedStoriesModel
                self.stories.append(contentsOf: model?.stories?.rows ?? [])
                self.storyTotalCount = model?.stories?.count ?? 0
                print(self.storyTotalCount)
                self.storyTotalCount == 0 ? self.collectionView.setEmptyView("No story found!") : self.collectionView.reloadData()
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
                        self.deletePost(route: .deletePost, method: .post, parameters: ["id": self.newsFeed[row].id ?? 0], model: SuccessModel.self, row: row)
                    }
                }
            }
        }
    }
    
    func deletePost<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, row: Int) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let delete):
                let successDetail = delete as? SuccessModel
                if successDetail?.success == true{
                    self.newsFeed.remove(at: row)
                    self.tableView.reloadData()
                    self.view.makeToast(successDetail?.message)
                }
                else{
                    self.view.makeToast(successDetail?.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }

    func share<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let success):
                let successDetail = success as? SuccessModel
                if successDetail?.success == true{
                    self.view.makeToast("Post shared successfully.")
                }
                else{
                    self.view.makeToast(successDetail?.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func wishList<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, feedCell : FeedTableViewCell) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let wish):
                let successDetail = wish as? SuccessModel
                feedCell.saveButton.setImage(successDetail?.message == "Wishlist Added" ? UIImage(named: "save-icon-red") : UIImage(named: "save-icon"), for: .normal)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, feedCell : FeedTableViewCell, index: Int) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let wish):
                let successDetail = wish as? SuccessModel
                feedCell.likeButton.setImage(successDetail?.message == "Liked" ? UIImage(named: "post-like") : UIImage(named: "like-black"), for: .normal)
                feedCell.likeCountLabel.text = successDetail?.message == "Liked" ? "\((self.newsFeed[index].likesCount ?? 0) + 1)" : "\((self.newsFeed[index].likesCount ?? 0) - 1)"
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
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
            Switcher.gotoViewerVC(delegate: self, position: 0, type: .image, imageUrl: stories[indexPath.row - 1].postFiles?[0].imageURL)
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
        cell.feed = newsFeed[indexPath.row]
        cell.actionBlock = {
            self.actionSheet(row: indexPath.row)
        }
        cell.shareActionBlock = {
            Utility.showAlert(message: "Do you want to share the post?", buttonTitles: ["No", "Yes"]) { responce in
                if responce == "Yes"{
                    self.share(route: .shareApi, method: .post, parameters: ["post_id": self.newsFeed[indexPath.row].post_id ?? 0], model: SuccessModel.self)
                }
            }
        }
        
        cell.likeActionBlock = {
            self.like(route: .likeApi, method: .post, parameters: ["section_id": self.newsFeed[indexPath.row].id ?? 0, "section": "post"], model: SuccessModel.self, feedCell: cell, index: indexPath.row)
        }
        cell.saveActionBlock = {
            self.wishList(route: .doWishApi, method: .post, parameters: ["section_id": self.newsFeed[indexPath.row].id ?? 0, "section": "post"], model: SuccessModel.self, feedCell: cell)
        }
        cell.commentActionBlock = {
            Switcher.gotoPostCommentVC(delegate: self, postId: self.newsFeed[indexPath.row].id ?? 0)
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





