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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTF.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        loadData()
    }
    
    private func loadData(){
        fetch(route: .suggestedUser, method: .post, parameters: ["page": currentPage, "limit": limit, "search": searchTF.text ?? ""], model: SuggestedUserModel.self)
    }
    

    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                let suggestedModel = model as? SuggestedUserModel
                self.suggestedUsers.append(contentsOf: suggestedModel?.suggestedUsers ?? [])
                self.totalCount = suggestedModel?.suggestedUsersCount ?? 0
                print(self.totalCount)
                self.totalCount == 0 ? self.collectionView.setEmptyView("No user found!") : nil
                self.collectionView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
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
