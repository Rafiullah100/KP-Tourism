//
//  ChatViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var topBarView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
    }
}
