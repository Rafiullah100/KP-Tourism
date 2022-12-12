//
//  ChatViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/6/22.
//

import UIKit
import MaterialComponents.MaterialTabs_TabBarView

class ChatListViewController: UIViewController {
    @IBOutlet weak var topBarView: UIView!

    @IBOutlet weak var tabbarView: MDCTabBarView!
    
    var tabbarItems = [UITabBarItem]()
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ChatListTableViewCell", bundle: nil), forCellReuseIdentifier: ChatListTableViewCell.cellReuseIdentifier())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        configureTabbar()
    }
    
    private func configureTabbar(){
        let section = ["Recent", "Unread", "Groups"]
        for i in 0..<section.count{
            let tabbarItem = UITabBarItem(title: section[i], image: nil, tag: i)
            tabbarItems.append(tabbarItem)
        }
        tabbarView.items = tabbarItems
        tabbarView.selectedItem = tabbarView.items[0]
        tabbarView.bottomDividerColor = .groupTableViewBackground
        tabbarView.rippleColor = .clear
        tabbarView.selectionIndicatorStrokeColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
        tabbarView.preferredLayoutStyle = .scrollableCentered
        tabbarView.isScrollEnabled = false
        tabbarView.setTitleFont(UIFont(name: "Roboto-Light", size: 15.0), for: .normal)
        tabbarView.setTitleFont(UIFont(name: "Roboto-Medium", size: 15.0), for: .selected)
        tabbarView.setTitleColor(.darkGray, for: .normal)
        tabbarView.setTitleColor(Constants.appColor, for: .selected)
//        tabbarView.tabBarDelegate = self
        tabbarView.minItemWidth = 10
    }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.cellReuseIdentifier()) as! ChatListTableViewCell
        if indexPath.row == 0{
            cell.statusIndicator.backgroundColor = Constants.onlineColor
        }
        else{
            cell.statusIndicator.backgroundColor = Constants.offlineColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.goToChatVC(delegate: self)
    }
}
