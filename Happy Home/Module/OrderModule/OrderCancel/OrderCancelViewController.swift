//
//  OrderCancelViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/6/24.
//

import UIKit

class OrderCancelViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var orderCancelLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.setTitle(LocalizationKeys.submit.rawValue.localizeString(), for: .normal)
        reasonLabel.text = LocalizationKeys.pleaseLeaveTheOrderCancelReason.rawValue.localizeString()
        orderCancelLabel.text = LocalizationKeys.requestOrderCancel.rawValue.localizeString()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
    }
    
    @IBAction func dimissButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
