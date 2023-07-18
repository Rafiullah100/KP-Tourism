//
//  AddTourPackageViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/21/23.
//

import UIKit
import SVProgressHUD
import SDWebImage
class AddTourPackageViewController: BaseViewController {
  
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
    
    @IBOutlet weak var wheelChairButton: UIButton!
    @IBOutlet weak var adultButton: UIButton!
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var childrenAgeTextField: UITextField!
    
    @IBOutlet weak var imageNameLabel: UILabel!
    var imagePicker: UIImagePickerController!
    var districtList: [DistrictsListRow]?

    
    let transportPickerView = UIPickerView()
    let transportTypePickerView = UIPickerView()
    let pricePickerView = UIPickerView()
    let fromPickerView = UIPickerView()
    let toPickerView = UIPickerView()

    var fromDistrictID: Int?
    var toDistrictID: Int?
    var groupTour: Bool?
    var postType: PostType?
    var tourPackage: UserProfileTourPackages?
    
        
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
        
        deadlineTextField.delegate = self
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        startTimeTextField.delegate = self
        endTimeTextField.delegate = self
        
        imageView.isHidden = true
        updateUI()
        
        fetch(route: .districtListApi, method: .post, parameters: ["limit": 50], model: DistrictListModel.self)
    }
    
    private func updateUI(){
        guard postType == .edit else {
            return
        }
        topLabel.text = postType == .post ? "Add Tour Package" : "Edit Tour Package"
        titleTextField.text = tourPackage?.title
        startDateTextField.text = tourPackage?.start_date
        endDateTextField.text = tourPackage?.endDate
        startTimeTextField.text = tourPackage?.start_time
        endTimeTextField.text = tourPackage?.end_time
        deadlineTextField.text = tourPackage?.deadline
        poepleTextField.text = "\(tourPackage?.number_of_people ?? 0)"
        adultTextField.text = "\(tourPackage?.no_of_adults ?? 0)"
        childrenTextField.text = "\(tourPackage?.children ?? 0)"
        priceTypeTextField.text = "\(tourPackage?.price ?? 0)"
        oldPriceTextField.text = "\(tourPackage?.price_old ?? 0)"
        newPriceTextField.text = "\(tourPackage?.price ?? 0)"
        priceTypeTextField.text = tourPackage?.price_type
        childrenAgeTextField.text = tourPackage?.children_age
        transportTextField.text = tourPackage?.transport
        transportTypeTextField.text = tourPackage?.transport_type
        transportTypeTextField.text = tourPackage?.transport_type
        emailTextField.text = tourPackage?.email
        phoneTextField.text = tourPackage?.phone_no
        descriptionTextField.text = tourPackage?.description
        familyButton.isSelected = tourPackage?.family ?? false
        adultButton.isSelected = tourPackage?.adults ?? false
        wheelChairButton.isSelected = tourPackage?.wheelchair ?? false
        yesImageView.image = UIImage(named: tourPackage?.group_tour == true ? "radio-select" : "radio-unselect")
        noImageView.image = UIImage(named: tourPackage?.group_tour == false ? "radio-select" : "radio-unselect")
        groupTour = tourPackage?.group_tour ?? false
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (tourPackage?.preview_image ?? "")))
    }
    
    @objc func myTargetFunction(textField: UITextField) {
        Switcher.showDatePicker(delegate: self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                self.districtList = (model as! DistrictListModel).districts?.rows
                self.fromPickerView.reloadAllComponents()
                self.toPickerView.reloadAllComponents()
                self.findFromDistrictObject()
                self.findToDistrictObject()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    private func findFromDistrictObject(){
        if let index = districtList?.firstIndex(where: { $0.id ==  tourPackage?.from_district_id }) {
            fromDistrictTextField.text = districtList?[index].title
            fromDistrictID = districtList?[index].id
        }
    }
    
    private func findToDistrictObject(){
        if let index = districtList?.firstIndex(where: { $0.id ==  tourPackage?.to_district_id }) {
            toDistrictTextField.text = districtList?[index].title
            toDistrictID = districtList?[index].id
        }
    }
    
    @IBAction func groupTourYesBtnAction(_ sender: Any) {
        groupTour = true
        yesImageView.image =  UIImage(named: "radio-select")
        noImageView.image =  UIImage(named: "radio-unselect")
    }
    
    @IBAction func groupTourNoBtnAction(_ sender: Any) {
        groupTour = false
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
        familyButton.isSelected = !familyButton.isSelected
    }
    
    @IBAction func adultImageView(_ sender: UIButton) {
        adultButton.isSelected = !adultButton.isSelected
    }
    
    @IBAction func wheelChairBtnAction(_ sender: Any) {
        wheelChairButton.isSelected = !wheelChairButton.isSelected
    }
    
    @IBAction func createBtnAction(_ sender: Any) {
       validate()
    }
    
    private func createTourPackage(route: Route, params: [String: Any]){
        Networking.shared.uploadMultipart(route: route, imageParameter: "preview_image", image: imageView.image ?? UIImage(), parameters: params) { result in
            switch result {
            case .success(let success):
                if success.success == true{
                    self.dismiss(animated: true) {
                        self.view.makeToast(success.message)
                    }
                }
                else{
                    self.view.makeToast(success.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    private func validate(){
        guard let title = titleTextField.text, !title.isEmpty,
              let fromDistrict = fromDistrictTextField.text, !fromDistrict.isEmpty,
              let toDistrict = toDistrictTextField.text, !toDistrict.isEmpty,
              let startDate = startDateTextField.text, !startDate.isEmpty,
              let endDate = endDateTextField.text, !endDate.isEmpty,
              let deadline = deadlineTextField.text, !deadline.isEmpty,
              let startTime = startTimeTextField.text, !startTime.isEmpty,
              let endTime = endTimeTextField.text, !endTime.isEmpty,
              let noOfpeople = poepleTextField.text, !noOfpeople.isEmpty,
              let noOfadult = adultTextField.text, !noOfadult.isEmpty,
              let noOfchildren = childrenTextField.text, !noOfchildren.isEmpty,
              let childrenAge = childrenAgeTextField.text, !childrenAge.isEmpty,
              let oldPrice = oldPriceTextField.text, !oldPrice.isEmpty,
              let newPrice = newPriceTextField.text, !newPrice.isEmpty,
              let priceType = priceTypeTextField.text, !priceType.isEmpty,
              let transportType = transportTypeTextField.text, !transportType.isEmpty,
              let transport = transportTextField.text, !transport.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let phone = phoneTextField.text, !phone.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty
              else {
            return
        }
        var para = ["title":title, "from_district_id": fromDistrictID ?? 0, "to_district_id": toDistrictID ?? 0, "price_old": oldPrice, "price": newPrice, "price_type": priceType, "family": familyButton.isSelected, "adults": adultButton.isSelected, "children": noOfchildren, "children_age": childrenAge, "number_of_people": noOfpeople, "no_of_adults": noOfadult, "wheelchair": wheelChairButton.isSelected, "group_tour": groupTour ?? "", "transport_type": transportType, "transport": transport, "phone_no": phone, "email": email, "start_date": startDate, "end_date": endDate, "start_time": startTime, "end_time": endTime, "deadline": deadline, "description": description] as [String : Any]
        if postType == .post{
            createTourPackage(route: .createPackage, params: para)
        }
        else if postType == .edit{
            para["tourPackageId"] = tourPackage?.id
            para["old_preview_image_path"] = tourPackage?.preview_image
            para["old_preview_image_path"] = tourPackage?.thumbnail_image
            print(para)
            createTourPackage(route: .updateTourPackage, params: para)
        }
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
            return Constants.transportType.count
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
            return Constants.transportType[row]
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
            transportTypeTextField.text = Constants.transportType[row]
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
            if let imageURL = info[.imageURL] as? URL {
                let imageName = imageURL.lastPathComponent
                imageNameLabel.text = imageName
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddTourPackageViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "DateTimeViewController") as! DateTimeViewController
        vc.timeClosure = { date in
            textField.text = date
        }
        if textField == startTimeTextField || textField == endTimeTextField{
            vc.dateFormate = .time
        }
        else{
            vc.dateFormate = .date
        }
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        textField.resignFirstResponder()
        self.present(vc, animated: true, completion: nil)
    }
}
