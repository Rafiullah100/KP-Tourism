//
//  AccomodationViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

class AccomodationViewController: BaseViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "AccomodationTableViewCell", bundle: nil), forCellReuseIdentifier: AccomodationTableViewCell.celldentifier)
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

extension AccomodationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccomodationTableViewCell = tableView.dequeueReusableCell(withIdentifier: AccomodationTableViewCell.celldentifier) as! AccomodationTableViewCell
        return cell
    }
}

extension AccomodationViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150.0
    }
}
