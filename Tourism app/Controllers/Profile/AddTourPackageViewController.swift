//
//  AddTourPackageViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/21/23.
//

import UIKit
import SVProgressHUD
class AddTourPackageViewController: UIViewController {
  
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var fromDistrictTextField: UITextField!
    @IBOutlet weak var toDistrictTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var deadlineTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var poepleTextField: UITextField!
    @IBOutlet weak var adultTextField: UITextField!
    @IBOutlet weak var childrenTextField: UITextField!
    @IBOutlet weak var oldPriceTextField: UITextField!
    @IBOutlet weak var newPriceTextField: UITextField!
    @IBOutlet weak var priceTypeTextField: UITextField!
    @IBOutlet weak var transportTypeTextField: UITextField!
    @IBOutlet weak var transportTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var yesImageView: UIImageView!
    @IBOutlet weak var noImageView: UIImageView!
    @IBOutlet weak var familyImageView: UIImageView!
    @IBOutlet weak var adultImageView: UIImageView!
    @IBOutlet weak var wheelChairImageView: UIImageView!
    
    var imagePicker: UIImagePickerController!

    var districtList: [DistrictsListRow]?

    
    let transportPickerView = UIPickerView()
    let transportTypePickerView = UIPickerView()
    let pricePickerView = UIPickerView()
    let fromPickerView = UIPickerView()
    let toPickerView = UIPickerView()

    var fromDistrictID: Int?
    var toDistrictID: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        transportPickerView.delegate = self
        transportPickerView.dataSource = self
        transportTypePickerView.delegate = self
        transportTypePickerView.dataSource = self
        pricePickerView.delegate = self
        pricePickerView.dataSource = self
        fromPickerView.delegate = self
        fromPickerView.dataSource = self
        toPickerView.delegate = self
        toPickerView.dataSource = self
        
        priceTypeTextField.inputView = pricePickerView
        transportTypeTextField.inputView = transportTypePickerView
        transportTextField.inputView = transportPickerView
        fromDistrictTextField.inputView = fromPickerView
        toDistrictTextField.inputView = toPickerView
        
        fetch(route: .districtListApi, method: .post, model: DistrictListModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                self.districtList = (model as! DistrictListModel).districts?.rows
                self.fromPickerView.reloadAllComponents()
                self.toPickerView.reloadAllComponents()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func groupTourYesBtnAction(_ sender: Any) {
        yesImageView.image =  UIImage(named: "radio-select")
        noImageView.image =  UIImage(named: "radio-unselect")
    }
    
    @IBAction func groupTourNoBtnAction(_ sender: Any) {
        yesImageView.image =  UIImage(named: "radio-unselect")
        noImageView.image =  UIImage(named: "radio-select")
    }
    
    @IBAction func takeImageBtnAction(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func familyBtnAction(_ sender: Any) {
        familyImageView.image =  UIImage(named: "check-list")
        //uncheck-list
    }
    
    @IBAction func adultImageView(_ sender: Any) {
        adultImageView.image =  UIImage(named: "check-list")
    }
    
    @IBAction func wheelChairBtnAction(_ sender: Any) {
        wheelChairImageView.image =  UIImage(named: "check-list")
    }
    @IBAction func createBtnAction(_ sender: Any) {
    }
}

extension AddTourPackageViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pricePickerView{
            return Constants.priceType.count
        }
        else if pickerView == transportTypePickerView{
            return Constants.priceType.count
        }
        else if pickerView == transportPickerView{
            return Constants.transport.count
        }
        else if pickerView == fromPickerView{
            return districtList?.count ?? 0
        }
        else if pickerView == toPickerView{
            return districtList?.count ?? 0
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pricePickerView{
            return Constants.priceType[row]
        }
        else if pickerView == transportTypePickerView{
            return Constants.priceType[row]
        }
        else if pickerView == transportPickerView{
            return Constants.transport[row]
        }
        else if pickerView == fromPickerView{
            return districtList?[row].title
        }
        else if pickerView == toPickerView{
            return districtList?[row].title
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pricePickerView{
            priceTypeTextField.text = Constants.priceType[row]
        }
        else if pickerView == transportTypePickerView{
            transportTypeTextField.text = Constants.priceType[row]
        }
        else if pickerView == transportPickerView{
            transportTextField.text = Constants.transport[row]
        }
        else if pickerView == fromPickerView{
            fromDistrictID = districtList?[row].id
            fromDistrictTextField.text = districtList?[row].title
        }
        else if pickerView == toPickerView{
            toDistrictID = districtList?[row].id
            toDistrictTextField.text = districtList?[row].title
        }
    }
}

extension AddTourPackageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleToFill
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
