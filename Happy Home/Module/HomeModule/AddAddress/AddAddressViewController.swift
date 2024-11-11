//
//  AddNewAddressViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/5/24.
//

import UIKit

class AddAddressViewController: UIViewController {
    @IBOutlet weak var navigationView: NavigationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.delegate = self
        navigationView.titleLabel.text = "Add New Address"
    }
    @IBAction func addNewAddressButtonAction(_ sender: Any) {
        Switcher.gotoChooseLoc(delegate: self)
    }
    @IBAction func updateButtonAction(_ sender: Any) {
        Switcher.gotoChooseLoc(delegate: self)
    }
}

extension AddAddressViewController: NavigationViewDelegate{
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
