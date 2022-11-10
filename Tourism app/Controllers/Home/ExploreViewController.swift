//
//  ExploreViewController.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit

class ExploreViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ExploreTableViewCell", bundle: nil), forCellReuseIdentifier: ExploreTableViewCell.cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(tableViewScrolling), name: Notification.Name(Constants.enableScrolling), object: nil)
    }
    
    @objc func tableViewScrolling(){
        tableView.isScrollEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ExploreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExploreTableViewCell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.cellIdentifier) as! ExploreTableViewCell
        Helper.shared.slideShow(images: ["Mask Group 4", "Mask Group 15", "Mask Group 14", "Mask Group 5"], scrollView: cell.scrollView, container: tableView)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(move))
        singleTap.cancelsTouchesInView = false
        singleTap.numberOfTapsRequired = 1
        cell.scrollView.addGestureRecognizer(singleTap)
        cell.pageController.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        cell.actionBlock = {
            cell.favoriteButton.setBackgroundImage(UIImage(named: "favorite"), for: .normal)
        }
        return cell
    }
    
    @objc func move(){
        Switcher.goToDestination(delegate: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        move()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//       tableView.didScrolled()
    }
}

extension ExploreViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}
