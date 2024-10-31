//
//  GroupTourViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 10/30/24.
//

import UIKit

class GroupTourViewController: UIViewController, UINavigationControllerDelegate {

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
        if fileType == .itinerary{
            itineraryLabel.text = filename
        }
        else if fileType == .personDetail{
            personDetailLabel.text = filename
        }
    }
}

extension GroupTourViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let imageURL = info[.imageURL] as? URL {
                let imageName = imageURL.lastPathComponent
                if imageType == .companyLicense{
                    companyLicenseLabel.text = imageName
                }
                else if imageType == .companyGuide{
                    guideLicenseLabel.text = imageName
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
