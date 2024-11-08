//
//  IndividualTourViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 10/30/24.
//

import UIKit

class IndividualTourViewController: BaseViewController {

    @IBOutlet weak var hotelTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var arrivalDateTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var visaTextField: UITextField!
    @IBOutlet weak var passportTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    let pickerView = UIPickerView()
    var gender: String?
    var touristType: TouristType = .individual

    override func viewDidLoad() {
        super.viewDidLoad()
        genderTextField.inputView = pickerView
        arrivalDateTextField.delegate = self
        textView.delegate = self
        textView.textColor = .lightGray
        textView.text = "Enter Details here.."
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let passportNumber = passportTextField.text ?? ""
        let visaNumber = visaTextField.text ?? ""
        let mobile = mobileTextField.text ?? ""
        let country = countryTextField.text ?? ""
        let arrivalDate = arrivalDateTextField.text ?? ""
        let destination = destinationTextField.text ?? ""
        let hotelAddress = hotelTextField.text ?? ""
        let description = textView.text ?? ""
        if name == "" || email == "" || passportNumber == "" || visaNumber == "" || mobile == "" || country == "" || arrivalDate == "" || destination == "" || arrivalDate == "" || destination == "" || hotelAddress == "" || description == "" || gender == ""{
            self.view.makeToast("Enter all fields.")
        }
        else{
            let params = ["tour_type": touristType.rawValue, "name": name, "email": email, "passport_no": passportNumber, "visa_number": visaNumber, "mobile_no": mobile, "gender": gender ?? "male", "country": country, "date_entry": arrivalDate, "destinations": destination, "hotel_address": hotelAddress, "description": description] as [String : Any]
            print(params)
            self.register(route: .touristRegistration, parameters: params)
        }
    }
    
    func register(route: Route, parameters: [String: Any]? = nil) {
        dataTask = URLSession.shared.request(route: route, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let register):
                if register.success == true{
                    self.nameTextField.text = ""
                    self.emailTextField.text = ""
                    self.passportTextField.text = ""
                    self.visaTextField.text = ""
                    self.genderTextField.text = ""
                    self.mobileTextField.text = ""
                    self.countryTextField.text = ""
                    self.arrivalDateTextField.text = ""
                    self.destinationTextField.text = ""
                    self.hotelTextField.text = ""
                    self.textView.text = ""
                }
                self.showAlert(title: "", message: register.message?.stripOutHtml() ?? "")
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

extension IndividualTourViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter Details here.."
            textView.textColor = .lightGray
        }
    }
}

extension IndividualTourViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "DateTimeViewController") as! DateTimeViewController
        vc.timeClosure = { date in
            textField.text = date
        }
        
        vc.dateFormate = .date
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        textField.resignFirstResponder()
        self.present(vc, animated: true, completion: nil)
    }
}

extension IndividualTourViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Constants.gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = Constants.gender[row]
        self.gender = Constants.gender[row]
    }
}
