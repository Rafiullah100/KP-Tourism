//
//  DateTimeViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/23/23.
//

import UIKit

class DateTimeViewController: UIViewController {

    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dateFormate: DateFormate?
    
    var timeClosure: ((String) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if dateFormate == .date{
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
        }
        else{
            datePicker.datePickerMode = .time
            datePicker.preferredDatePickerStyle = .wheels
        }
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func okBtnAction(_ sender: Any) {
        if dateFormate == .date{
            timeClosure?(Helper.shared.date(date: datePicker.date, formate: "dd/MM/yyyy"))
        }
        else if dateFormate == .time{
            timeClosure?(Helper.shared.date(date: datePicker.date, formate: "HH:mm"))
        }
        
        
        self.dismiss(animated: true)
    }
}
