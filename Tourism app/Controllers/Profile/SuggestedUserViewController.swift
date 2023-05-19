//
//  SuggestedUserViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/14/23.
//

import UIKit
import SVProgressHUD
class SuggestedUserViewController: UIViewController {

        
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            collectionView.register(UINib(nibName: "SuggestedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SuggestedCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    private enum ApiType {
         case suggestedUser
         case follow
     }
    
    var totalCount = 0
    var currentPage = 1
    var limit = 20
    
    var suggestedUsers: [SuggestedUser] = [SuggestedUser]()
    private var apiType: ApiType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTF.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        loadData()
    }
    
    private func loadData(){
        apiType = .suggestedUser
        fetch(route: .suggestedUser, method: .post, parameters: ["page": currentPage, "limit": limit, "search": searchTF.text ?? ""], model: SuggestedUserModel.self)
    }
    

    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, cell: SuggestedCollectionViewCell? = nil) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                if self.apiType == .suggestedUser {
                    let suggestedModel = model as? SuggestedUserModel
                    self.suggestedUsers.append(contentsOf: suggestedModel?.suggestedUsers ?? [])
                    self.totalCount = suggestedModel?.suggestedUsersCount ?? 0
                    self.suggestedUsers.count == 0 ? self.collectionView.setEmptyView("No user found!") : self.collectionView.reloadData()
                }
                else if self.apiType == .follow{
                    let res = model as! SuccessModel
                    if res.success == false {
                        SVProgressHUD.showError(withStatus: res.message)
                    }
                    else{
                        if res.message == "Followed"{
                            cell?.followButton.setTitle("UNFollow", for: .normal)
                        }
                        else if res.message == "Unfollowed"{
                            cell?.followButton.setTitle("Follow", for: .normal)
                        }
                    }
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}


extension SuggestedUserViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.suggestedUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SuggestedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestedCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! SuggestedCollectionViewCell
        cell.users = self.suggestedUsers[indexPath.row]
        cell.followAction = {
            self.apiType = .follow
            self.fetch(route: .doFollow, method: .post, parameters: ["uuid": self.suggestedUsers[indexPath.row].uuid ?? ""], model: SuccessModel.self, cell: cell)
        }
        return cell
    }
}

extension SuggestedUserViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 3
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if suggestedUsers.count != totalCount && indexPath.row == suggestedUsers.count - 1  {
            print(suggestedUsers.count, totalCount)
            currentPage = currentPage + 1
            loadData()
        }
    }
}

extension SuggestedUserViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        suggestedUsers = []
        currentPage = 1
        loadData()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        suggestedUsers = []
        currentPage = 1
        loadData()
        textField.resignFirstResponder()
        return true
    }
}
