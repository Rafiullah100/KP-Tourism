//
//  CardListViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/2/24.
//

import UIKit

class CardListViewController: UIViewController {

    @IBOutlet weak var addLabel: UIButton!
    @IBOutlet weak var shoppingView: ShoppingPaymentView!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: DynamicHeightTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: CardTableViewCell.cellReuseIdentifier())
        }
    }
    
    var selectedIndexPath: IndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingView.shoppingButton.setTitle(LocalizationKeys.Continue.rawValue.localizeString(), for: .normal)
        navigationView.titleLabel.text = LocalizationKeys.addNewCard.rawValue.localizeString()
        addLabel.setTitle(LocalizationKeys.addNewCard.rawValue.localizeString(), for: .normal)
        navigationView.delegate = self
        shoppingView.delegate = self

        self.tableView.layoutIfNeeded()
        self.tableViewHeight.constant = self.tableView.contentSize.height
    }
    
    @IBAction func addNewCardButtonAction(_ sender: Any) {
        Switcher.gotoAddNewCard(delegate: self)
    }
}

extension CardListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        cell.configure(isSelected: selectedIndexPath == indexPath)
        cell.didTapButton = {
            self.selectedIndexPath = indexPath
            self.tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension CardListViewController: NavigationViewDelegate{
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CardListViewController: ShoppingDelegate{
    func shoppingViewButtonAction() {
        Switcher.gotoOrderSuccess(delegate: self)
    }
}
