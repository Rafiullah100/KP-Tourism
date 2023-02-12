//
//  AlertViewController.swift
//  Tourism app
//
//  Created by Rafi on 11/11/2022.
//

import UIKit

class WeatherAlertViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var dropdownButton: UIButton!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherMiddleView: UIView!
    
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    enum CellType {
        case WeatherTableViewCell
        case AlertTableViewCell
    }
    
    //  return "/forecasts/v1/daily/5day/258970?apikey=YxA9P1FHvaurvZAk0kAc7d7utlJWGR97 HTTP/1.1"

    
    let pickerView = UIPickerView()
    let userType = ["Swat", "Lower Dir", "Upper Dir", "Shangla", "Buner", "Malakand"]

    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.cellIdentifier)
            tableView.register(UINib(nibName: "AlertTableViewCell", bundle: nil), forCellReuseIdentifier: AlertTableViewCell.cellIdentifier)
        }
    }
    
    var cellType: CellType?
    var warnings: [Warning]?
    var weatherDetail: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        pickerView.delegate = self
        pickerView.dataSource = self
        textField.isHidden = true
        textField.inputView = pickerView
        cellType = .WeatherTableViewCell
//        serverCall(type: .WeatherTableViewCell)
  
        fetch(route: .weatherApi, method: .get, model: WeatherModel.self)
    }
    
    @IBAction func updateBtnAction(_ sender: Any) {
        cellType = .WeatherTableViewCell
        changeCell(type: .WeatherTableViewCell)
    }
    @IBAction func dropDownBtnAction(_ sender: Any) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func alertBtnAction(_ sender: Any) {
        cellType = .AlertTableViewCell
        changeCell(type: .AlertTableViewCell)
    }
    
    private func changeCell(type: CellType){
        cellType = type
        switch type {
        case .WeatherTableViewCell:
            serverCall(type: .WeatherTableViewCell)
            weatherView.backgroundColor = Constants.darkGrayColor
            weatherLabel.textColor = .black
            alertView.backgroundColor = Constants.lightGrayColor
            alertLabel.textColor = Constants.blackishGrayColor
            weatherMiddleView.isHidden = false
        case .AlertTableViewCell:
            serverCall(type: .AlertTableViewCell)
            alertView.backgroundColor = Constants.darkGrayColor
            alertLabel.textColor = .black
            weatherView.backgroundColor = Constants.lightGrayColor
            weatherLabel.textColor = Constants.blackishGrayColor
            weatherMiddleView.isHidden = true
        }
        textField.resignFirstResponder()
        tableView.reloadData()
    }
    
    private func serverCall(type: CellType){
        switch type {
        case .AlertTableViewCell:
            fetch(route: .fetchAlerts, method: .get, model: AlertModel.self)
        case .WeatherTableViewCell:
            fetch(route: .weatherApi, method: .get, model: WeatherModel.self)
        }
    }
    
    private func updateUI(){
        districtLabel.text = dropDownLabel.text
        descriptionLabel.text = weatherDetail?.headline?.text
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    switch self.cellType {
                    case .AlertTableViewCell:
                        self.warnings = (model as? AlertModel)?.warnings
                        self.warnings?.count == 0 ? self.tableView.setEmptyView() : self.tableView.reloadData()
                    case .WeatherTableViewCell:
                        self.weatherDetail = model as? WeatherModel
                        self.tableView.reloadData()
                        self.updateUI()
                    case .none:
                        print("none")
                    }
                }
            case .failure(let error):
                if error == .noInternet {
                    self.tableView.noInternet()
                }
            }
        }
    }
}

extension WeatherAlertViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch cellType {
        case .AlertTableViewCell:
            return warnings?.count ?? 0
        case .WeatherTableViewCell:
            return weatherDetail?.dailyForecasts?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellType {
        case .WeatherTableViewCell:
            let cell: WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.cellIdentifier) as! WeatherTableViewCell
            cell.dailyForecast = weatherDetail?.dailyForecasts?[indexPath.row]
            return cell
        case .AlertTableViewCell:
            let cell: AlertTableViewCell = tableView.dequeueReusableCell(withIdentifier: AlertTableViewCell.cellIdentifier) as! AlertTableViewCell
            cell.warning = warnings?[indexPath.row]
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

extension WeatherAlertViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        userType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fetch(route: .weatherApi, method: .get, model: WeatherModel.self)
        dropDownLabel.text = userType[row]
    }
}

extension WeatherAlertViewController: UITextFieldDelegate{

    
}
