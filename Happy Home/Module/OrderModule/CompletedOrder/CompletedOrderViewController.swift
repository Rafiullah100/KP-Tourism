//
//  CompletedOrderViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/6/24.
//

import UIKit

class CompletedOrderViewController: UIViewController , ProductNavigationViewDelegate {
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var navigationView: OrderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.label.text = "View Order"
        navigationView.delegate = self
        navigationView.leftIconImageView.image = UIImage(named: "back-circle-arrow")
    }


}
