//
//  FeedsViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/5/22.
//

import UIKit
import ReadMoreTextView
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
    var stories: [FeedStories]?
    var expandedCells = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        topBarView.addBottomShadow()
        
        tableView.estimatedRowHeight = 400.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchFeeds(route: .fetchFeeds, method: .post, model: NewsFeedModel.self)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func fetchFeeds<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let feeds):
                DispatchQueue.main.async {
                    self.newsFeed = (feeds as! NewsFeedModel).feeds
                    self.stories = (feeds as! NewsFeedModel).stories
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension FeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StatusCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! StatusCollectionViewCell
        cell.stories = stories?[indexPath.row]
        cell.cellType = indexPath.row == 0 ? .userSelf : .other
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
        cell.feed = newsFeed?[indexPath.row]
        cell.textView.shouldTrim = !expandedCells.contains(indexPath.row)
        cell.textView.setNeedsUpdateTrim()
        cell.textView.layoutIfNeeded()
        
        let readMoreTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: view.tintColor,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
                ]
                let readLessTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.red,
                    NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16)
                ]
        cell.textView.attributedReadMoreText = NSAttributedString(string: "... Read more", attributes: readMoreTextAttributes)
        cell.textView.attributedReadLessText = NSAttributedString(string: " Read less", attributes: readLessTextAttributes)
        cell.textView.maximumNumberOfLines = 2
        cell.textView.shouldTrim = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let cell: FeedTableViewCell = tableView.cellForRow(at: indexPath) as! FeedTableViewCell
//        cell.textView.onSizeChange = { [unowned tableView, unowned self] r in
//            let point = tableView.convert(r.bounds.origin, from: r)
//            guard let indexPath = tableView.indexPathForRow(at: point) else { return }
//            if r.shouldTrim {
//                self.expandedCells.remove(indexPath.row)
//            } else {
//                self.expandedCells.insert(indexPath.row)
//            }
//            tableView.reloadData()
//        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: FeedTableViewCell = tableView.cellForRow(at: indexPath) as! FeedTableViewCell
        cell.textView.shouldTrim = !cell.textView.shouldTrim
    }
}
