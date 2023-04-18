//
//  OTPViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 4/18/23.
//

import UIKit

class OTPViewController: BaseViewController {

    @IBOutlet weak var otpTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .title
        viewControllerTitle = "OTP"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
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
