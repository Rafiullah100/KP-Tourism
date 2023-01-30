//
//  TourDestinationViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/30/23.
//

import UIKit

class TourDestinationViewController: BaseViewController {
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .visitKP
        viewControllerTitle = "Tour Planner"
        
        tableViewHeight.constant = CGFloat.greatestFiniteMagnitude
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableViewHeight.constant = tableView.contentSize.height
    }
}

extension TourDestinationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoTourAccomodationVC(delegate: self)
    }
}


