//
//  BeforeSignUpViewController.swift
//  HappyHome
//
//  Created by NGEN on 31/10/2024.
//

import UIKit

struct settingData {
    let text:String?
    let icon:String?
}

class BeforeSignUpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var display:[settingData]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PreferrencesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        display = [settingData(text: "Language  / English", icon: "language"),
                   settingData(text: "Customer Feedback", icon: "Star"),
                   settingData(text: "Share App", icon: "share"),
                   settingData(text: "Terms and Condions", icon: "error"),
                   settingData(text: "Contact Us", icon: "message-call")
        ]
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return display?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PreferrencesTableViewCell
        cell.displaySettings(data: display[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        }
        
    }
}
