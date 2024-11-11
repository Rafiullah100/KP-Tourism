//
//  AddNewCardViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/4/24.
//

import UIKit


class AddNewCardViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!{
        didSet{
            dateTextField.delegate = self
        }
    }
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var navigationView: NavigationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.delegate = self
        navigationView.titleLabel.text = "Add Card"
        self.navigationController?.navigationBar.isHidden = true
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        cardNumberTextField.addTarget(self, action: #selector(cardNumberTextFieldDidChange), for: .editingChanged)
    }
    
    @objc func nameTextFieldDidChange(_ textField: UITextField) {
        nameLabel.text = textField.text
    }
    
    @objc func cardNumberTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let cleanedText = text.replacingOccurrences(of: " ", with: "")
        let formattedText = cleanedText.enumerated().map { index, character -> String in
            return (index % 4 == 0 && index > 0) ? " \(character)" : "\(character)"
        }.joined()
        textField.text = formattedText
        cardNumberLabel.text = formattedText
    }

    @IBAction func addButtonAction(_ sender: Any) {
    }
}

extension AddNewCardViewController: NavigationViewDelegate{
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddNewCardViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Switcher.gotoDate(delegate: self)
    }
}

extension AddNewCardViewController: DateDelegate{
    func didSelectDate(_ date: String) {
        dateTextField.resignFirstResponder()
        dateLabel.text = date
        dateTextField.text = date
    }
}
