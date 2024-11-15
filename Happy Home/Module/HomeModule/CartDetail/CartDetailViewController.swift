//
//  CardDetailViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/3/24.
//

import UIKit

class CartDetailViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var couponTextField: UITextField!
    @IBOutlet weak var urgentDeliveryButton: UIButton!
    @IBOutlet weak var normalDeliveryButton: UIButton!
    @IBOutlet weak var urgentDeliveryView: UIView!
    @IBOutlet weak var normalDeliveryView: UIView!
    @IBOutlet weak var shoppingView: ShoppingPaymentView!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CartDetailTableViewCell", bundle: nil), forCellReuseIdentifier: CartDetailTableViewCell.cellReuseIdentifier())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        couponTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        shoppingView.delegate = self
        navigationView.delegate = self
        navigationView.titleLabel.text = LocalizationKeys.payment.rawValue.localizeString()
        normalDeliveryButton.setTitle(LocalizationKeys.normalDelivery.rawValue.localizeString(), for: .normal)
        urgentDeliveryButton.setTitle(LocalizationKeys.urgentDelivery.rawValue.localizeString(), for: .normal)
        couponTextField.placeholder = LocalizationKeys.addCoupon.rawValue.localizeString()
        applyButton.setTitle(LocalizationKeys.apply.rawValue.localizeString(), for: .normal)
        itemLabel.text = LocalizationKeys.items.rawValue.localizeString()

        shoppingView.shoppingButton.setTitle(LocalizationKeys.Continue.rawValue.localizeString(), for: .normal)
    }
    
    @IBAction func normalDeliveryButtonAction(_ sender: Any) {
        normalDeliveryView.backgroundColor = CustomColor.yellowColor.color
        urgentDeliveryView.backgroundColor = .clear
        
    }
    @IBAction func urgentDeliveryButtonAction(_ sender: Any) {
        urgentDeliveryView.backgroundColor = CustomColor.yellowColor.color
        normalDeliveryView.backgroundColor = .clear
    }
    
    
    @IBAction func applyButtonAction(_ sender: Any) {
    }
}

extension CartDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CartDetailTableViewCell", for: indexPath) as! CartDetailTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension CartDetailViewController: NavigationViewDelegate{
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CartDetailViewController: ShoppingDelegate{
    func shoppingViewButtonAction() {
        Switcher.gotoDeliverySchedule(delegate: self)
    }
}
