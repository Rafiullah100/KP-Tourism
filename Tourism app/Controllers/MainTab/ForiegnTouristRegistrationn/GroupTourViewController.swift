//
//  GroupTourViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 10/30/24.
//

import UIKit

class GroupTourViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var guideLicenseTextField: UITextField!
    @IBOutlet weak var guideContactTextField: UITextField!
    @IBOutlet weak var guideNameTextField: UITextField!
    @IBOutlet weak var vehicleNumberTextField: UITextField!
    @IBOutlet weak var vehicleTypeTextField: UITextField!
    @IBOutlet weak var driverNicTextField: UITextField!
    @IBOutlet weak var driverContactTextField: UITextField!
    @IBOutlet weak var driverNameTextField: UITextField!
    @IBOutlet weak var companyLicenseTextField: UITextField!
    @IBOutlet weak var companyContactTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var arrivalDateTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var totalPersonTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var guideLicenseLabel: UILabel!
    @IBOutlet weak var personDetailLabel: UILabel!
    @IBOutlet weak var itineraryLabel: UILabel!
    @IBOutlet weak var companyLicenseLabel: UILabel!
    var fileType: FileType?
    var imageType: ImageType?
    var touristType: TouristType = .group
    
    var itineraryData: Data?
    var personDetailData: Data?
    var guideLicenseData: Data?
    var companyLicenseData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        arrivalDateTextField.delegate = self
        textView.delegate = self
        textView.textColor = .lightGray
        textView.text = "Enter Details here.."
        
    }
    
    @IBAction func itineraryBtnAction(_ sender: Any) {
        fileType = .itinerary
        pickFile()
    }
    
    @IBAction func personDetailBtnAction(_ sender: Any) {
        fileType = .personDetail
        pickFile()
    }
    
    @IBAction func guideLicenseBtnAction(_ sender: Any) {
        imageType = .companyGuide
        pickImage()
    }
    
    @IBAction func companyLicenseBtnAction(_ sender: Any) {
        imageType = .companyLicense
        pickImage()
    }
    
    private func pickFile(){
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.item])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    private func pickImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let totalPerson = totalPersonTextField.text ?? ""
        let country = countryTextField.text ?? ""
        let arrivalDate = arrivalDateTextField.text ?? ""
        let destination = destinationTextField.text ?? ""
        
        let companyName = companyNameTextField.text ?? ""
        let companyEmail = emailTextField.text ?? ""
        let companyContact = companyContactTextField.text ?? ""
        let companyLicense = companyLicenseTextField.text ?? ""
        
        let guideName = guideNameTextField.text ?? ""
        let guideContact = guideContactTextField.text ?? ""
        let guideLicense = guideLicenseTextField.text ?? ""

        let driverName = driverNameTextField.text ?? ""
        let driverContact = driverContactTextField.text ?? ""
        let driverCNIC = driverNicTextField.text ?? ""
        let driverVehicleType = vehicleTypeTextField.text ?? ""
        let driverVehicleNumber = vehicleNumberTextField.text ?? ""
        
        let description = textView.text ?? ""
        
        if totalPerson == "" || country == "" || arrivalDate == "" || destination == "" || companyName == "" || companyEmail == "" || companyContact == "" || companyLicense == "" || guideName == "" || guideContact == "" || guideLicense == "" || driverName == "" || driverContact == "" || driverCNIC == "" || driverVehicleType == "" || driverVehicleNumber == "" || description == "" || itineraryData == nil || personDetailData == nil || guideLicenseData == nil || companyLicenseData == nil{
            self.view.makeToast("Enter all fields.")
        }
        else{
            let parameters: [String: Any] = [
                "tour_type": touristType.rawValue,
                "name": "",
                "passport_no": "",
                "visa_number": "",
                "gender": "",
                "email": companyEmail,
                "mobile_no": companyContact,
                "date_entry": arrivalDate,
                "destinations": destination,
                "country": country,
                "company_name": companyName,
                "company_licence_no": companyLicense,
                "total_persons": totalPerson,
                "guide_name": guideName,
                "guide_licence_no": guideLicense,
                "guide_contact": guideContact,
                "driver_name": driverName,
                "driver_contact": driverContact,
                "driver_cnic": driverCNIC,
                "vehicle_type": driverVehicleType,
                "vehicle_no": driverVehicleNumber,
                "description": description,
                "hotel_address": ""
            ]
            
            let files: [String: (data: Data, mimeType: String)] = [
                "company_licence_file": (data: companyLicenseData ?? Data(), mimeType: "image/jpeg"),
                "guide_licence_file": (data: guideLicenseData ?? Data(), mimeType: "image/jpeg"),
                "persons_detail_file": (data: personDetailData ?? Data(), mimeType: "application/pdf"),
                "hotels_detail_file": (data: itineraryData ?? Data(), mimeType: "application/pdf")
            ]
            register(parameters: parameters, files: files)
        }
    }
    
    private func register(parameters: [String: Any], files: [String: (data: Data, mimeType: String)]) {
        Networking.shared.registerGroup(route: .touristRegistration, files: files, parameters: parameters) { result in
            switch result {
            case .success(let register):
                if register.success == true{
                    self.totalPersonTextField.text = ""
                    self.countryTextField.text = ""
                    self.arrivalDateTextField.text = ""
                    self.destinationTextField.text = ""
                    self.companyNameTextField.text = ""
                    self.emailTextField.text = ""
                    self.companyContactTextField.text = ""
                    self.companyLicenseTextField.text = ""
                    self.guideNameTextField.text = ""
                    self.guideContactTextField.text = ""
                    self.guideLicenseTextField.text = ""
                    self.driverNicTextField.text = ""
                    self.driverNameTextField.text = ""
                    self.driverContactTextField.text = ""
                    self.vehicleTypeTextField.text = ""
                    self.vehicleNumberTextField.text = ""
                    self.textView.text = ""
                    self.itineraryData = nil
                    self.personDetailData = nil
                    self.guideLicenseData = nil
                    self.companyLicenseData = nil
                    self.guideLicenseLabel.text = ""
                    self.companyLicenseLabel.text = ""
                    self.itineraryLabel.text = ""
                    self.personDetailLabel.text = ""
                }
                self.showAlert(title: "", message: register.message?.stripOutHtml() ?? "")
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

extension GroupTourViewController: UITextViewDelegate{
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

extension GroupTourViewController: UITextFieldDelegate{
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

extension GroupTourViewController: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        let filename = selectedFileURL.lastPathComponent
        
        do {
            // Convert the selected file URL to Data
            let fileData = try Data(contentsOf: selectedFileURL)
            
            // Check the file type and assign the filename to the corresponding label
            if fileType == .itinerary {
                itineraryLabel.text = filename
                // Store or process `fileData` as needed, e.g., store it in a variable
                self.itineraryData = fileData
            } else if fileType == .personDetail {
                personDetailLabel.text = filename
                // Store or process `fileData` as needed
                self.personDetailData = fileData
            }
        } catch {
            print("Failed to convert file to Data: \(error)")
        }
    }

}

extension GroupTourViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            // Extract the image URL if available
            if let imageURL = info[.imageURL] as? URL {
                let imageName = imageURL.lastPathComponent
                
                // Convert the picked image to Data (JPEG format in this example)
                let imageData = pickedImage.jpegData(compressionQuality: 0.5) // Adjust quality as needed
                
                // Check the image type and store the image data and name accordingly
                if imageType == .companyLicense {
                    companyLicenseLabel.text = imageName
                    self.companyLicenseData = imageData // Store the data for later use
                } else if imageType == .companyGuide {
                    guideLicenseLabel.text = imageName
                    self.guideLicenseData = imageData // Store the data for later use
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
