//
//  ItinraryDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/8/23.
//

import UIKit

class ItinraryDetailViewController: BaseViewController {

    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ItinraryDaysTableViewCell", bundle: nil), forCellReuseIdentifier: ItinraryDaysTableViewCell.cellReuseIdentifier())
        }
    }
    
    var itinraryDetail: ItinraryRow?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableviewHeight.constant = self.tableView.contentSize.height
    }
}

extension ItinraryDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItinraryDaysTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ItinraryDaysTableViewCell") as! ItinraryDaysTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}
