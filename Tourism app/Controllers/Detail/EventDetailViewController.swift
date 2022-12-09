//
//  EventDetailViewController.swift
//  Tourism app
//
//  Created by Rafi on 08/11/2022.
//

import UIKit

class EventDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "Events, Swat"
    }
}
