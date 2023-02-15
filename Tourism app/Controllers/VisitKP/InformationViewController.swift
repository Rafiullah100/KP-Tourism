//
//  InformationViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/2/23.
//

import UIKit

class InformationCell: UITableViewCell {
    //
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var checkImgView: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkImgView.image = selected ? UIImage(named: "check") : UIImage(named: "uncheck")
    }

}

class InformationViewController: BaseViewController {

    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var isSelected: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .visitKP
        viewControllerTitle = "Tour Planner"
        
        tableViewHeight.constant = CGFloat.greatestFiniteMagnitude
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableViewHeight.constant = tableView.contentSize.height
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        Switcher.gotoTourInformationVC(delegate: self)
    }
    @IBAction func moveForwardBtn(_ sender: Any) {
        if isSelected == true{
            Switcher.gotoTourAccomodationVC(delegate: self)
        }
    }
}


extension InformationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.traveleInformation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InformationCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! InformationCell
        cell.label.text = Constants.traveleInformation[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Switcher.gotoTourAccomodationVC(delegate: self)
        isSelected = true
        UserDefaults.standard.information = Constants.traveleInformation[indexPath.row]
    }
}
