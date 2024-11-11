//
//  CardDetailViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/3/24.
//

import UIKit

class CartDetailViewController: UIViewController {

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
        shoppingView.delegate = self
        navigationView.delegate = self
        navigationView.titleLabel.text = "Payment"
        shoppingView.shoppingButton.setTitle("Continue", for: .normal)       
    }
    
    @IBAction func normalDeliveryButtonAction(_ sender: Any) {
        normalDeliveryView.backgroundColor = CustomColor.yellowColor.color
        urgentDeliveryView.backgroundColor = .clear
        
    }
    @IBAction func urgentDeliveryButtonAction(_ sender: Any) {
        urgentDeliveryView.backgroundColor = CustomColor.yellowColor.color
        normalDeliveryView.backgroundColor = .clear
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
