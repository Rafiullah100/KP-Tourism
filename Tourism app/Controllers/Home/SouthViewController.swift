//
//  SouthViewController.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit

class SouthViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "SouthTableViewCell", bundle: nil), forCellReuseIdentifier: SouthTableViewCell.cellIdentifier)
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

extension SouthViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SouthTableViewCell = tableView.dequeueReusableCell(withIdentifier: SouthTableViewCell.cellIdentifier) as! SouthTableViewCell
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       tableView.didScrolled()
    }
}

extension SouthViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}
