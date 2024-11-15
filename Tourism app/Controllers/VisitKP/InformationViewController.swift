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
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var isSelected: Bool?
    var districtID: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .visitKP
        viewControllerTitle = "Tour Planner"
    
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func moveForwardBtn(_ sender: Any) {
        if isSelected == true{
            guard let selectedIndices = tableView.indexPathsForSelectedRows else { return }
            let selectedInformation = selectedIndices.map { Constants.traveleInformation[$0.item] }
            UserDefaults.standard.information = selectedInformation.map({$0}).joined(separator: ",")
            Switcher.gotoTourAccomodationVC(delegate: self, districtID: districtID ?? 0)
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
    }
}
