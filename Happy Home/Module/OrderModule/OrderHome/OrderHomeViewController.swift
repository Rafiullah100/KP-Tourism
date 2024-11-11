//
//  OrderHomeViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/6/24.
//

import UIKit
enum OrderType {
case current
    case completed
    case cancelled
}
class OrderHomeViewController: UIViewController, ProductNavigationViewDelegate {
    func back() {
        //
    }
    

    @IBOutlet weak var cancelLineView: UIView!
    @IBOutlet weak var cancelLabel: UILabel!
    @IBOutlet weak var completedLineView: UIView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var currentLineView: UIView!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var navigationView: OrderView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: OrderTableViewCell.cellReuseIdentifier())
        }
    }
    var orderType: OrderType = .cancelled
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.delegate = self
        navigationView.leftIconImageView.image = UIImage(named: "Notification")
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        switchView(orderType: .current)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func currentButtonAction(_ sender: Any) {
        switchView(orderType: .current)
    }
    
    @IBAction func completedButtonAction(_ sender: Any) {
        switchView(orderType: .completed)
    }
    @IBAction func canceledButtonAction(_ sender: Any) {
        switchView(orderType: .cancelled)
    }
    
    private func switchView(orderType: OrderType){
        self.orderType = orderType
        tableView.reloadData()
        switch orderType {
        case .current:
            currentLabel.textColor = .black
            completedLabel.textColor = .lightGray
            cancelLabel.textColor = .lightGray
            currentLineView.isHidden = false
            completedLineView.isHidden = true
            cancelLineView.isHidden = true
        case .completed:
            currentLabel.textColor = .lightGray
            completedLabel.textColor = .black
            cancelLabel.textColor = .lightGray
            currentLineView.isHidden = true
            completedLineView.isHidden = false
            cancelLineView.isHidden = true
        case .cancelled:
            currentLabel.textColor = .lightGray
            completedLabel.textColor = .lightGray
            cancelLabel.textColor = .black
            currentLineView.isHidden = true
            completedLineView.isHidden = true
            cancelLineView.isHidden = false
        }
    }
}

extension OrderHomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellReuseIdentifier(), for: indexPath) as! OrderTableViewCell
        cell.configureStatusView(type: orderType)
        cell.didTapButton = {
            if self.orderType == .current{
                Switcher.gotoCurrentOrder(delegate: self)
            }
            else{
                Switcher.gotoCompletedOrder(delegate: self)
            }
        }
        return cell
    }
    
}
