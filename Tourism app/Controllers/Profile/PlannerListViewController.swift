//
//  PlannerListViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 8/11/23.
//

import UIKit

class PlannerTableViewCell: UITableViewCell {
//    var experienceID: Int?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("selected")
    }
}


class PlannerListViewController: UIViewController {
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var navigationLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()

    }

}

extension PlannerListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! PlannerTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}



