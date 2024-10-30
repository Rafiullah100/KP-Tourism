//
//  ForeignTouristRegistrationViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 10/30/24.
//

import UIKit

class ForeignTouristRegistrationViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var individualTabView: UIView!
    @IBOutlet weak var groupTabView: UIView!
    
    lazy var groupVC: GroupTourViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "GroupTourViewController") as! GroupTourViewController
    }()
    
    lazy var individualVC: IndividualTourViewController = {
        UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "IndividualTourViewController") as! IndividualTourViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        show(groupVC, sender: self)
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        add(vc, in: containerView)
    }

    @IBAction func groupTourBtnAction(_ sender: Any) {
        individualTabView.backgroundColor = .clear
        groupTabView.backgroundColor = UIColor.systemGray5
        show(groupVC, sender: self)
    }
 
    @IBAction func individualBtnAction(_ sender: Any) {
        individualTabView.backgroundColor = UIColor.systemGray5
        groupTabView.backgroundColor = .clear
        show(individualVC, sender: self)
    }
}
