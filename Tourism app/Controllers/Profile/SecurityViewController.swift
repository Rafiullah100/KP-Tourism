//
//  SecurityViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit

class SecurityViewController: UIViewController {
    @IBOutlet weak var topBarView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
    }
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
