//
//  VisitKPViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/27/23.
//

import UIKit

class AreaTableViewCell: UITableViewCell {
    //
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var selectedImgView: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    var area: VisitArea? {
        didSet {
            imgView.image = UIImage(named: area?.image ?? "")
            nameLabel.text = area?.title
            bgImageView.image = UIImage(named: area?.background ?? "")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedImgView.isHidden = selected ? false : true
    }

}

class VisitKPViewController: BaseViewController {

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
        navigationController?.navigationBar.isHidden = false
        type = .visitKP
        viewControllerTitle = "Tour Planner"
        
        tableViewHeight.constant = CGFloat.greatestFiniteMagnitude
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableViewHeight.constant = tableView.contentSize.height
    }
    
    @IBAction func forwardBtnAction(_ sender: Any) {
        if isSelected == true{
            Switcher.gotoVisitExpVC(delegate: self)
        }
    }
}

extension VisitKPViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.visitkpArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AreaTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! AreaTableViewCell
        cell.area = Constants.visitkpArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Switcher.gotoVisitExpVC(delegate: self)
        isSelected = true
        UserDefaults.standard.area = Constants.visitkpArray[indexPath.row].title
    }
}


