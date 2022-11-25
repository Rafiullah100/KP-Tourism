//
//  EventsViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit

class EventsViewController: BaseViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: EventTableViewCell.cellReuseIdentifier())
        }
    }
    var locationCategory: LocationCategory?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        updateUI()
    }
    
    func updateUI() {
        switch locationCategory {
        case .district:
            thumbnailTopLabel.text = "Swat"
            thumbnailBottomLabel.text = "KP"
            thumbnail.image = UIImage(named: "Path 94")
        case .tourismSpot:
            thumbnailTopLabel.text = "Kalam"
            thumbnailBottomLabel.text = "Swat"
            thumbnail.image = UIImage(named: "iten")
        default:
            break
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoEventDetail(delegate: self)
    }
}
