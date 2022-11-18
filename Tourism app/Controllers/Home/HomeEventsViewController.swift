//
//  HomeEventsViewController.swift
//  Tourism app
//
//  Created by Rafi on 19/10/2022.
//

import UIKit

class HomeEventsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: EventTableViewCell.cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension HomeEventsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.cellIdentifier) as! EventTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}

 

