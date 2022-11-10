//
//  TourViewController.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit

class TourViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "TourTableViewCell", bundle: nil), forCellReuseIdentifier: TourTableViewCell.cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(tableViewScrolling), name: Notification.Name(Constants.enableScrolling), object: nil)
    }
    
    @objc func tableViewScrolling(){
        tableView.isScrollEnabled = true
    }
}

extension TourViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TourTableViewCell = tableView.dequeueReusableCell(withIdentifier: TourTableViewCell.cellIdentifier) as! TourTableViewCell
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//       tableView.didScrolled()
    }
}

extension TourViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350.0
    }
}
