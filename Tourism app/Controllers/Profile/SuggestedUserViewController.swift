//
//  SuggestedUserViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/14/23.
//

import UIKit
import SVProgressHUD
class SuggestedUserViewController: BaseViewController {

    @IBOutlet weak var topView: UIView!
    
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
        topView.viewShadow()
        loadData()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    private func loadData(){
        fetch(parameters: ["page": currentPage, "limit": limit, "search": searchTF.text ?? ""])
    }

    func fetch(parameters: [String: Any]) {
        URLSession.shared.request(route: .suggestedUser, method: .post, parameters: parameters, model: SuggestedUserModel.self) { result in
            switch result {
            case .success(let user):
                self.suggestedUsers.append(contentsOf: user.suggestedUsers)
                self.totalCount = user.suggestedUsersCount ?? 0
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.goToProfileVC(delegate: self, profileType: .otherUser, uuid: suggestedUsers[indexPath.row].uuid ?? "")
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
