//
//  SellerViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit

class SellerViewController: UIViewController {
   
    @IBOutlet weak var topBarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
    }
    

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
