//
//  ProfileViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/7/22.
//

import UIKit
import MaterialComponents.MaterialTabs_TabBarView

class ProfileViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tabbarView: MDCTabBarView!
    @IBOutlet weak var topProfileView: UIView!
    
    @IBOutlet weak var statusCollectionView: UICollectionView!{
        didSet{
            statusCollectionView.dataSource = self
            statusCollectionView.delegate = self
            statusCollectionView.register(UINib(nibName: "StatusCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StatusCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.cellReuseIdentifier())
        }
    }
    var tabbarItems = [UITabBarItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        topProfileView.layer.shadowColor = UIColor.black.cgColor
        topProfileView.layer.shadowOpacity = 1
        topProfileView.layer.shadowOffset = .zero
        topProfileView.layer.shadowRadius = 10
        topProfileView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 30.0)
        configureTabbar()
    }
    
    private func configureTabbar(){
        let section = ["Post", "Products", "Blogs"]
        for i in 0..<section.count{
            let tabbarItem = UITabBarItem(title: section[i], image: nil, tag: i)
            tabbarItems.append(tabbarItem)
        }
        tabbarView.items = tabbarItems
        tabbarView.selectedItem = tabbarView.items[0]
        tabbarView.bottomDividerColor = .clear
        tabbarView.rippleColor = .clear
        tabbarView.selectionIndicatorStrokeColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
        tabbarView.preferredLayoutStyle = .scrollableCentered
        tabbarView.isScrollEnabled = false
        tabbarView.setTitleFont(UIFont(name: "Poppins-Medium", size: 15.0), for: .normal)
        tabbarView.setTitleFont(UIFont(name: "Poppins-Medium", size: 15.0), for: .selected)
        tabbarView.setTitleColor(.lightGray, for: .normal)
        tabbarView.setTitleColor(.black, for: .selected)
        tabbarView.minItemWidth = 100.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight.constant = collectionView.contentSize.height
        var scrollHeight: CGFloat = topProfileView.frame.height
        scrollHeight += tabbarView.frame.height
        scrollHeight += statusView.frame.height
        scrollHeight += tableViewHeight.constant
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollHeight + 10.0)
    }
    
    @IBAction func followerBtnAction(_ sender: Any) {
        Switcher.showFollower(delegate: self)
    }
    @IBAction func settingBtnAction(_ sender: Any) {
        Switcher.goToSettingVC(delegate: self)
    }
    @IBAction func favoriteBtnAction(_ sender: Any) {
        Switcher.goToWishlistVC(delegate: self)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case statusCollectionView:
            let cell: StatusCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! StatusCollectionViewCell
            cell.cellType = indexPath.row == 0 ? .userSelf : .other
            return cell
        case collectionView:
            let cell: ProfileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! ProfileCollectionViewCell
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case statusCollectionView:
            return CGSize(width: 80, height: 110)
        case collectionView:
            let cellsAcross: CGFloat = 3
            let spaceBetweenCells: CGFloat = 2
            let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
            return CGSize(width: width, height: width)
        default:
            break
        }
        return CGSize.zero
    }
}
