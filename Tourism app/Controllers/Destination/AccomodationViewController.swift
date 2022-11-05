//
//  AccomodationViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

class AccomodationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "AccomodationTableViewCell", bundle: nil), forCellReuseIdentifier: AccomodationTableViewCell.celldentifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension AccomodationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccomodationTableViewCell = tableView.dequeueReusableCell(withIdentifier: AccomodationTableViewCell.celldentifier) as! AccomodationTableViewCell
        cell.bgView.layer.borderWidth = 0.5
        cell.bgView.layer.borderColor = UIColor.lightGray.cgColor
        cell.bgView.layer.cornerRadius = 15.0
        return cell
    }
}

extension AccomodationViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150.0
    }
}
