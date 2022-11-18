//
//  BlogsViewController.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit

class BlogsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "BlogTableViewCell", bundle: nil), forCellReuseIdentifier: BlogTableViewCell.cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func tableViewScrolling(){
        tableView.isScrollEnabled = true
    }
}

extension BlogsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BlogTableViewCell = tableView.dequeueReusableCell(withIdentifier: BlogTableViewCell.cellIdentifier) as! BlogTableViewCell
        return cell
    }
    
}

extension BlogsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
}
