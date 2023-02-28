//
//  FeedsViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/5/22.
//

import UIKit

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
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: FeedTableViewCell.cellReuseIdentifier())
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        topBarView.addBottomShadow()
        tableView.rowHeight = UITableView.automaticDimension
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
}

extension FeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StatusCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! StatusCollectionViewCell
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellReuseIdentifier()) as! FeedTableViewCell
        if indexPath.row == 1 {
            cell.imgbgView.isHidden = true
        }
        return cell
    }
}
