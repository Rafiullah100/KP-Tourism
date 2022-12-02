//
//  SignupViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/2/22.
//

import UIKit

class SignupViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .title
        viewControllerTitle = "Sign up"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func gotoLogin(_ sender: Any) {
        Switcher.goToLoginVC(delegate: self)
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
