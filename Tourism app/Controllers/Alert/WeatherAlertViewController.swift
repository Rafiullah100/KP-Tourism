//
//  AlertViewController.swift
//  Tourism app
//
//  Created by Rafi on 11/11/2022.
//

import UIKit

class WeatherAlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherMiddleView: UIView!
    
    enum CellType {
        case WeatherTableViewCell
        case AlertTableViewCell
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.cellIdentifier)
            tableView.register(UINib(nibName: "AlertTableViewCell", bundle: nil), forCellReuseIdentifier: AlertTableViewCell.cellIdentifier)
        }
    }
    
    var cellType: CellType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        cellType = .WeatherTableViewCell
    }
    
    @IBAction func updateBtnAction(_ sender: Any) {
        changeCell(type: .WeatherTableViewCell)
    }
    
    @IBAction func alertBtnAction(_ sender: Any) {
        changeCell(type: .AlertTableViewCell)
    }
    
    private func changeCell(type: CellType){
        cellType = type
        switch type {
        case .WeatherTableViewCell:
            weatherView.backgroundColor = Constants.darkGrayColor
            weatherLabel.textColor = .black
            alertView.backgroundColor = Constants.lightGrayColor
            alertLabel.textColor = Constants.blackishGrayColor
            weatherMiddleView.isHidden = false
        case .AlertTableViewCell:
            alertView.backgroundColor = Constants.darkGrayColor
            alertLabel.textColor = .black
            weatherView.backgroundColor = Constants.lightGrayColor
            weatherLabel.textColor = Constants.blackishGrayColor
            weatherMiddleView.isHidden = true
        }
        tableView.reloadData()
    }
}

extension WeatherAlertViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellType {
        case .WeatherTableViewCell:
            let cell: WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.cellIdentifier) as! WeatherTableViewCell
            return cell
        case .AlertTableViewCell:
            let cell: AlertTableViewCell = tableView.dequeueReusableCell(withIdentifier: AlertTableViewCell.cellIdentifier) as! AlertTableViewCell
            return cell
        default:
           return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellType {
        case .WeatherTableViewCell:
            return 200
        case .AlertTableViewCell:
            return 140.0
        default:
            return 0
        }
    }

}



