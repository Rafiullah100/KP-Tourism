//
//  DateViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/9/24.
//

import UIKit
protocol DateDelegate {
    func didSelectDate(_ date: String)
}
class DateViewController: UIViewController {
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    var delegate: DateDelegate?
    var dateString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        dateString = formatter.string(from: selectedDate)
    }
    
    @IBAction func okButtonAction(_ sender: Any) {
        delegate?.didSelectDate(dateString ?? "")
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
