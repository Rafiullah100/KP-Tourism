//
//  DestinationViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 11/22/22.
//

import UIKit

class DestinationViewController: BaseViewController {

    @IBOutlet weak var contentView: UIView!
    lazy var gettingHereVC: UIViewController = {
        UIStoryboard(name: "Destination", bundle: nil).instantiateViewController(withIdentifier: "GettingHereViewController")
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        add(gettingHereVC, in: contentView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
