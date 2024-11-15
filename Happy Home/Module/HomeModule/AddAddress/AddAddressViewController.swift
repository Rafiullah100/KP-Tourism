//
//  AddNewAddressViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/5/24.
//

import UIKit

class AddAddressViewController: UIViewController {
   
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var addressValueLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var chooseMapLabel: UILabel!
    @IBOutlet weak var addLocationLabel: UILabel!
    
    @IBOutlet weak var navigationView: NavigationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.delegate = self
        navigationView.titleLabel.text = LocalizationKeys.addNewAddress.rawValue.localizeString()
        addLocationLabel.text = LocalizationKeys.addLocation.rawValue.localizeString()
        chooseMapLabel.text = LocalizationKeys.chooseOnMap.rawValue.localizeString()
        addressLabel.text = LocalizationKeys.address.rawValue.localizeString()
        updateButton.setTitle(LocalizationKeys.updateAddress.rawValue.localizeString(), for: .normal)

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
