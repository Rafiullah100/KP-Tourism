//
//  EventsViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit

class EventsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "AccomodationTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension EventsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as! EventTableViewCell
        return cell
    }
}

extension EventsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
}
