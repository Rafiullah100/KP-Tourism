//
//  ProfileViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/9/24.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "PreferrencesTableViewCell", bundle: nil), forCellReuseIdentifier: PreferrencesTableViewCell.cellReuseIdentifier())
        }
    }
    
    var arr = [settingData(text: "My Cart", icon: "cart"),
               settingData(text: "Wishlist", icon: "wish-list"),
               settingData(text: "Language  / English", icon: "language"),
               settingData(text: "Customer Feedback", icon: "Star"),
               settingData(text: "Share App", icon: "share"),
               settingData(text: "Terms and Condions", icon: "error"),
               settingData(text: "Contact Us", icon: "message-call")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func logoutButtonAction(_ sender: Any) {
        Switcher.logout(delegate: self)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PreferrencesTableViewCell.cellReuseIdentifier(), for: indexPath) as! PreferrencesTableViewCell
        cell.displaySettings(data: arr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            Switcher.gotoWishlist(delegate: self)
        }
        else if indexPath.row == 2{
            Switcher.gotoLanguage(delegate: self)
        }
    }
}
