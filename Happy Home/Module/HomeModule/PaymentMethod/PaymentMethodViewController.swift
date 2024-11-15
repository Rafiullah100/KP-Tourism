//
//  PaymentMethodViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/2/24.
//

import UIKit


class PaymentMethodViewController: UIViewController {

    @IBOutlet weak var shoppingView: ShoppingPaymentView!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: DynamicHeightTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "PaymentMethodTableViewCell", bundle: nil), forCellReuseIdentifier: PaymentMethodTableViewCell.cellReuseIdentifier())
        }
    }
    
    var selectedIndexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingView.delegate = self
        navigationView.delegate = self
        shoppingView.shoppingButton.setTitle(LocalizationKeys.placeOrder.rawValue.localizeString(), for: .normal)
        navigationView.titleLabel.text = LocalizationKeys.selectPaymentMethod.rawValue.localizeString()
        self.tableView.layoutIfNeeded()
        self.tableViewHeight.constant = self.tableView.contentSize.height
    }
}

extension PaymentMethodViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.paymentMethod.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PaymentMethodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodTableViewCell", for: indexPath) as! PaymentMethodTableViewCell
        cell.configure(isSelected: selectedIndexPath == indexPath)
        cell.payment = Constants.paymentMethod[indexPath.row]
        cell.didTapButton = {
            self.selectedIndexPath = indexPath
            self.tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension PaymentMethodViewController: NavigationViewDelegate{
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PaymentMethodViewController: ShoppingDelegate{
    func shoppingViewButtonAction() {
        Switcher.gotoPaymentCard(delegate: self)
    }
}
