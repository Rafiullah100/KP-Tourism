//
//  PersonalInfoViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit
import SVProgressHUD
import SDWebImage
class PersonalInfoViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var bioTextField2: UITextField!
    @IBOutlet weak var bioTextField1: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var topBarView: UIView!

    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        emailTextField.text = UserDefaults.standard.userEmail
        nameTextField.text = UserDefaults.standard.name?.capitalized
        bioTextField1.text = UserDefaults.standard.userBio
        guard let profileImage = UserDefaults.standard.profileImage, profileImage.contains("https") else {
            profileImageView.sd_setImage(with: URL(string: Route.baseUrl + (UserDefaults.standard.profileImage ?? "")))
            return }
        profileImageView.sd_setImage(with: URL(string: UserDefaults.standard.profileImage ?? ""))
    }

    @IBAction func takePicture(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func updateProfile(route: Route, params: [String: Any]){
        Networking.shared.updateProfile(route: route, imageParameter: "profile_image", image: profileImageView.image ?? UIImage(), parameters: params) { result in
            switch result {
            case .success(let profile):
                if profile.success == true{
                    UserDefaults.standard.name = profile.data?.name
                    UserDefaults.standard.userEmail = profile.data?.email
                    UserDefaults.standard.profileImage = profile.data?.profileImage
                    UserDefaults.standard.userBio = profile.data?.about
                    SVProgressHUD.showSuccess(withStatus: profile.message)
                }
                else{
                    SVProgressHUD.showError(withStatus: profile.message)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func updateProfileBtnAction(_ sender: Any) {
        guard let name = nameTextField.text, let email = emailTextField.text, let bio = bioTextField1.text, !name.isEmpty,!email.isEmpty, !bio.isEmpty else {
            self.view.makeToast("All fields are required.")
            return  }
        updateProfile(route: .updateProfile, params: ["name": name, "email": email, "bio": bio])
    }
    
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PersonalInfoViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.contentMode = .scaleToFill
            profileImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
