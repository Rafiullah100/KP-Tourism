//
//  PersonalInfoViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit
import SVProgressHUD
import SDWebImage
import PhotosUI

class PersonalInfoViewController: BaseViewController, UINavigationControllerDelegate {

    @IBOutlet weak var bioTextField2: UITextField!
    @IBOutlet weak var bioTextField1: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var topBarView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        emailTextField.text = UserDefaults.standard.userEmail
        nameTextField.text = UserDefaults.standard.name?.capitalized
        bioTextField1.text = UserDefaults.standard.userBio
        profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()))
    }

    @IBAction func takePicture(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.presentPhotoLibrary()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }

    private func presentCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true)
        } else {
            self.view.makeToast("Camera is not available")
        }
    }

    private func presentPhotoLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }

    private func updateProfile(route: Route, params: [String: Any]){
        Networking.shared.updateProfile(route: route, imageParameter: "profile_image", image: profileImageView.image ?? UIImage(), parameters: params) { result in
            switch result {
            case .success(let profile):
                print(profile)
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
            return
        }
        updateProfile(route: .updateProfile, params: ["name": name, "email": email, "bio": bio])
    }

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PersonalInfoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        if let itemprovider = results.first?.itemProvider {
            if itemprovider.canLoadObject(ofClass: UIImage.self) {
                itemprovider.loadObject(ofClass: UIImage.self) { image, error in
                    if let selectedImage = image as? UIImage {
                        DispatchQueue.main.async {
                            self.profileImageView.image = selectedImage
                        }
                    }
                }
            }
        }
    }
}

extension PersonalInfoViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
