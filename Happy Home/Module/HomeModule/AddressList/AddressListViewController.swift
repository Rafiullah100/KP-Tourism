//
//  AddressListViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/2/24.
//

import UIKit

class AddressListViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var addButton: UILabel!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: DynamicHeightTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: AddressTableViewCell.cellReuseIdentifier())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.titleLabel.text = LocalizationKeys.changeShippingAddress.rawValue.localizeString()
        addButton.text = LocalizationKeys.addNewAddress.rawValue.localizeString()
        continueButton.setTitle(LocalizationKeys.Continue.rawValue.localizeString(), for: .normal)
        navigationView.delegate = self

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.layoutIfNeeded()
        self.tableViewHeight.constant = self.tableView.contentSize.height
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        Switcher.gotoAddAddress(delegate: self)
    }
}

extension AddressListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
        cell.didEditTapped = {
            Switcher.gotoChooseLoc(delegate: self)
        }
        cell.defaultView.isHidden = !(indexPath.row == 0)
        cell.addressLabel.text = "\(LocalizationKeys.address.rawValue.localizeString()) \(indexPath.row)"
        return cell
    }
}

extension AddressListViewController: NavigationViewDelegate{
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
