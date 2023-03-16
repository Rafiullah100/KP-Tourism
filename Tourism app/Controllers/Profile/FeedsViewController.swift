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
            tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: FeedTableViewCell.cellReuseIdentifier())
        }
    }
    
    var newsFeed: [FeedModel]?
    var stories: StoriesModel?
    var states : Array<Bool>!
    let pickerView = UIPickerView()
    var numberOfCells : NSInteger = 0

    let setting = ["edit", "delete"]
    var dispatchGroup: DispatchGroup?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        topBarView.addBottomShadow()
        pickerView.delegate = self
        pickerView.dataSource = self
        tableView.estimatedRowHeight = 400.0
        tableView.rowHeight = UITableView.automaticDimension
        loadFeed()
        NotificationCenter.default.addObserver(self, selector: #selector(loadFeed), name: NSNotification.Name(rawValue: Constants.loadFeed), object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func postBtnAction(_ sender: Any) {
        Switcher.gotoPostVC(delegate: self, postType: .post)
    }
    @IBAction func chatBtnAction(_ sender: Any) {
        Switcher.goToChatListVC(delegate: self)
    }
    @IBAction func profileBtnAction(_ sender: Any) {
        Switcher.goToProfileVC(delegate: self)
    }
    
    
    @objc func loadFeed(){
        dispatchGroup = DispatchGroup()
        dispatchGroup?.enter()
        fetchFeedsStories(route: .feedStories, method: .post, model: FeedStoriesModel.self)
        dispatchGroup?.enter()
        fetchFeeds(route: .fetchFeeds, method: .post, model: NewsFeedModel.self)
    }
    
    func fetchFeeds<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            self.dispatchGroup?.leave()
            switch result {
            case .success(let feeds):
                self.newsFeed = (feeds as! NewsFeedModel).feeds
//                self.stories = (feeds as! NewsFeedModel).stories
                self.numberOfCells = self.newsFeed?.count ?? 0
                self.states = [Bool](repeating: true, count: self.numberOfCells)
                self.tableView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    func fetchFeedsStories<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            self.dispatchGroup?.leave()
            switch result {
            case .success(let feedStories):
                self.stories = (feedStories as! FeedStoriesModel).stories
                self.collectionView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    private func actionSheet(row: Int){
        let alert = UIAlertController(title: "", message: "choose action", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
            Switcher.gotoPostVC(delegate: self, postType: .edit, feed: self.newsFeed?[row])
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            guard let postID = self.newsFeed?[row].id else { return }
            print(postID)
            self.deletePost(route: .deletePost, method: .post, parameters: ["id": postID], model: SuccessModel.self, row: row)
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
                    self.newsFeed?.remove(at: row)
                    self.tableView.reloadData()
                    SVProgressHUD.showSuccess(withStatus: "Post deleted.")
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}

extension FeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (stories?.count ?? 0) + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StatusCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! StatusCollectionViewCell
        cell.cellType = indexPath.row == 0 ? .userSelf : .other
        if indexPath.row == 0 {
            cell.imgView.image = UIImage(named: "placeholder")
        }
        else{
//            cell.stories = stories?.rows[indexPath.row - 1]
            cell.stories = stories?.rows[indexPath.row - 1]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            Switcher.gotoPostVC(delegate: self, postType: .story)
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
        return newsFeed?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellReuseIdentifier()) as! FeedTableViewCell
        cell.layoutIfNeeded()
        cell.expandableLabel.delegate = self
//        cell.expandableLabel.collapsed = states[indexPath.row]
        cell.feed = newsFeed?[indexPath.row]
        cell.actionBlock = {
            self.actionSheet(row: indexPath.row)
        }
        return cell
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





