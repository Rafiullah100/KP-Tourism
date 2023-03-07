//
//  TourAccomodationViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/30/23.
//

import UIKit

class TravelAccomodation: UITableViewCell {
    //
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var selectedImgView: UIImageView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imageBGView: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedImgView.isHidden = selected ? false : true
    }
    
    var travel: Destination? {
        didSet {
            imgView.image = UIImage(named: travel?.image ?? "")
            label.text = travel?.title
            
            bottomView.clipsToBounds = true
            bottomView.layer.cornerRadius = 10
            bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

            imageBGView.clipsToBounds = true
            imageBGView.layer.cornerRadius = 10
            imageBGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomView.viewShadow()
        }
    }
}

class TourAccomodationViewController: BaseViewController {
  
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
    
    @IBAction func forwardBtnAction(_ sender: Any) {
        if isSelected == true{
            Switcher.gotoTourpdfVC(delegate: self)
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension TourAccomodationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.traveleAccomodation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TravelAccomodation = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! TravelAccomodation
        cell.travel = Constants.traveleAccomodation[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Switcher.gotoTourpdfVC(delegate: self)
        isSelected = true
        UserDefaults.standard.accomodation = Constants.traveleAccomodation[indexPath.row].title
    }
}


