//
//  SignupViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/2/22.
//

import UIKit

class SignupViewController: BaseViewController {
    
    let pickerView = UIPickerView()
    let userType = ["Tourist", "Seller"]
    
    @IBOutlet weak var userTypeTextField: UITextField!
    @IBOutlet weak var userTypeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .title
        viewControllerTitle = "Sign up"
        userTypeTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        userTypeButton.setTitle(userType[0], for: .normal)
    }
    
    @IBAction func gotoLogin(_ sender: Any) {
        Switcher.goToLoginVC(delegate: self)
    }
    
    @IBAction func userTypeBtnAction(_ sender: Any) {
        userTypeTextField.becomeFirstResponder()
    }
}

extension SignupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        userType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userTypeButton.setTitle(userType[row], for: .normal)
    }
}
