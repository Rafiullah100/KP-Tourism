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
    var storyLimit = 20

    var storyTotalCount = 1
    var storyCurrentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        topBarView.addBottomShadow()
        pickerView.delegate = self
        pickerView.dataSource = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(loadNewsFeed), name: NSNotification.Name(rawValue: Constants.loadFeed), object: nil)
        loadData()
        guard let url = UserDefaults.standard.profileImage, url.contains("https") else {
            profileImageView.sd_setImage(with: URL(string: Route.baseUrl + (UserDefaults.standard.profileImage ?? "")))
            return }
        profileImageView.sd_setImage(with: URL(string: url))
        profileButton.sd_setBackgroundImage(with: URL(string: url), for: .normal)
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
    
    @objc func loadNewsFeed(){
        fetchFeeds(route: .fetchFeeds, method: .post, parameters: ["page": currentPage, "limit": limit, "token": UserDefaults.standard.accessToken ?? ""], model: NewsFeedModel.self)
    }
    
    @objc func storyApiCall(){
        fetchFeedsStories(route: .feedStories, method: .post, parameters: ["page": currentPage, "limit": storyLimit], model: FeedStoriesModel.self)
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
                SVProgressHUD.showError(withStatus: error.localizedDescription)
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
                self.storyTotalCount == 0 ? self.collectionView.setEmptyView("No story found!") : self.collectionView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    private func actionSheet(row: Int){
        let alert = UIAlertController(title: "", message: "choose action", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
            Switcher.gotoPostVC(delegate: self, postType: .edit, feed: self.newsFeed[row])
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deletePost(route: .deletePost, method: .post, parameters: ["id": self.newsFeed[row].id ?? 0], model: SuccessModel.self, row: row)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        }))
        present(alert, animated: true)
    }
    
    func deletePost<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, row: Int) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let delete):
                let successDetail = delete as? SuccessModel
                if successDetail?.success == true{
                    self.newsFeed.remove(at: row)
                    self.tableView.reloadData()
                    SVProgressHUD.showSuccess(withStatus: successDetail?.message)
                }
                else{
                    SVProgressHUD.showError(withStatus: successDetail?.message)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }

    func share<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let success):
                let successDetail = success as? SuccessModel
                if successDetail?.success == true{
                    SVProgressHUD.showSuccess(withStatus: "Post shared successfully.")
                }
                else{
                    SVProgressHUD.showError(withStatus: successDetail?.message)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    func wishList<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, feedCell : FeedTableViewCell) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let wish):
                let successDetail = wish as? SuccessModel
                feedCell.saveButton.setImage(successDetail?.message == "Wishlist Added" ? UIImage(named: "save-icon-red") : UIImage(named: "save-icon"), for: .normal)
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, feedCell : FeedTableViewCell) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let wish):
                let successDetail = wish as? SuccessModel
                feedCell.likeButton.setImage(successDetail?.message == "Liked" ? UIImage(named: "Arrow---Top-red") : UIImage(named: "Arrow---Top"), for: .normal)
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
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
//            cell.imgView.image = UIImage(named: "placeholder")
            print(Route.baseUrl + (UserDefaults.standard.profileImage ?? ""))
            cell.imgView.sd_setImage(with: URL(string: UserDefaults.standard.profileImage ?? ""), placeholderImage: UIImage(named: "placeholder"))

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
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if stories.count != storyTotalCount && indexPath.row == stories.count {
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
            self.share(route: .shareApi, method: .post, parameters: ["post_id": self.newsFeed[indexPath.row].post_id ?? 0], model: SuccessModel.self)
        }
        
        cell.likeActionBlock = {
            self.like(route: .likeApi, method: .post, parameters: ["section_id": self.newsFeed[indexPath.row].id ?? 0, "section": "post"], model: SuccessModel.self, feedCell: cell)
        }
        cell.saveActionBlock = {
            self.wishList(route: .doWishApi, method: .post, parameters: ["section_id": self.newsFeed[indexPath.row].id ?? 0, "section": "post"], model: SuccessModel.self, feedCell: cell)
        }
        cell.commentActionBlock = {
            Switcher.gotoPostCommentVC(delegate: self)
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





