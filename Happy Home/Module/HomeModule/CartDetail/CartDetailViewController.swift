//
//  CardDetailViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/3/24.
//

import UIKit

class CartDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CartDetailTableViewCell", bundle: nil), forCellReuseIdentifier: CartDetailTableViewCell.cellReuseIdentifier())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
