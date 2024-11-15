//
//  OrderSuccessViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/6/24.
//

import UIKit

class OrderSuccessViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var congrateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setTitle(LocalizationKeys.backToHome.rawValue.localizeString(), for: .normal)
        successLabel.text = LocalizationKeys.yourOrderHasBeenSuccesssfullyPlaced.rawValue.localizeString()
        congrateLabel.text = LocalizationKeys.congratulations.rawValue.localizeString()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func gotoHomeButtonAction(_ sender: Any) {
        Switcher.gotoHome(delegate: self)
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
