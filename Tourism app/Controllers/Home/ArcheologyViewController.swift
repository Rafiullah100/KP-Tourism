//
//  ArcheologyViewController.swift
//  Tourism app
//
//  Created by Rafi on 08/11/2022.
//

import UIKit

class ArcheologyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ArchTableViewCell", bundle: nil), forCellReuseIdentifier: ArchTableViewCell.cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(tableViewScrolling), name: Notification.Name(Constants.enableScrolling), object: nil)
    }
    
    @objc func tableViewScrolling(){
        tableView.isScrollEnabled = true
    }
}

extension ArcheologyViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArchTableViewCell = tableView.dequeueReusableCell(withIdentifier: ArchTableViewCell.cellIdentifier) as! ArchTableViewCell
        return cell
    }
}

extension ArcheologyViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}
