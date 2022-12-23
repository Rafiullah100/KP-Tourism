//
//  PackageDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 11/30/22.
//

import UIKit


class PackageDetailCell: UITableViewCell{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}


class PackageDetailViewController: BaseViewController {
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    
    var selectedRow: Int?
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "Naran Package"
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension PackageDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PackageDetailCell = tableView.dequeueReusableCell(withIdentifier: "cell_identifier") as! PackageDetailCell
        cell.subTitleLabel.isHidden = true
        if indexPath.row == selectedRow{
            cell.subTitleLabel.isHidden = false
            cell.imgView.image = #imageLiteral(resourceName: "expand")
        }
        else{
            cell.subTitleLabel.isHidden = true
            cell.imgView.image = #imageLiteral(resourceName: "collapse")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        tableView.reloadData()
        let cell: PackageDetailCell = tableView.cellForRow(at: indexPath) as! PackageDetailCell
        tableViewHeight.constant = tableView.contentSize.height + cell.subTitleLabel.frame.height
//        cell.subTitleLabel.isHidden = false
    }
}


